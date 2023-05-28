//
//  OAuthAuthenticator.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Configs
import Factory
import Foundation
import Loggers

final class OAuthAuthenticator: Authenticator {
    @Injected(\.network)
    var network

    @Injected(\.cache)
    private var cache

    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.token))
    }

    func refresh(
        _ credential: OAuthCredential,
        for session: Session,
        completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        Log.info("Trying to refresh auth token")
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let request = RefreshTokenRequest(refreshToken: credential.refreshToken)
                let refreshedCredentials = try await self.network
                    .call(api: AuthEndpoint.refreshToken(request))
                    .decode(onSuccessAs: OAuthCredential.self, onStatusCodeThrow: [422: UnauthorizedError()])
                completion(.success(refreshedCredentials))
            } catch is UnauthorizedError {
                cache.removeSensitiveData()
                NotificationCenter.default.post(.userNeedsToReauthenticate)
                completion(.failure(UnauthorizedError().whileLogging([.network, .authentication])))
            } catch {
                completion(.failure(error.whileLogging([.network, .authentication])))
            }
        }
    }

    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        urlRequest.headers["Authorization"] == HTTPHeader.authorization(bearerToken: credential.token).value
    }
}
