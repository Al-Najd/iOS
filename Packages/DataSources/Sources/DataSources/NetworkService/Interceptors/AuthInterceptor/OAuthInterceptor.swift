//
//  OAuthInterceptor.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Configs
import Factory
import Foundation

final class OAuthInterceptor {
    @CodableCacheWrapper(key: .authToken)
    var authToken: OAuthCredential?

    var interceptor: AuthenticationInterceptor<OAuthAuthenticator> {
        let authenticator = OAuthAuthenticator()
        return AuthenticationInterceptor(
            authenticator: authenticator,
            credential: authToken,
            refreshWindow: .init(
                interval: Container.shared.networkConfig().retryDelay,
                maximumAttempts: Container.shared.networkConfig().retryLimit))
    }
}
