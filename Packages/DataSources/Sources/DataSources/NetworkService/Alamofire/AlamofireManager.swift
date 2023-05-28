//
//  AlamofireManager.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Configs
import Foundation

// MARK: - AlamofireManager

public final class AlamofireManager: NetworkProtocol {
    private let uploader: Uploader
    // NOTE in Review: Marking this internal for when moving this to a different Package
    let session: Session
    private let authenticator: OAuthInterceptor

    init(
        session: Session = NetworkConfig.Alamofire.session,
        authenticator: OAuthInterceptor = .init()) {
        self.session = session
        self.authenticator = authenticator
        uploader = .init(session: session)
    }
}

// MARK: - Direct API Call
public extension AlamofireManager {
    @discardableResult
    func call(api: Endpoint) async throws -> CAFUResponse {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            let request = self.session.request(
                URLRequestFactory.generateRequest(outOf: api),
                interceptor: self.getRequestInterceptor(for: api))

            request.responseData { response in
                if let error = response.error {
                    continuation.resume(throwing: error.asNetworkError())
                } else if let statusCode = response.response?.statusCode, statusCode.isEmpty {
                    continuation.resume(
                        returning: .init(
                            data: .init(),
                            statusCode: statusCode,
                            metadata: response.toCAFUResponse(request.task)))
                } else if let data = response.data, let statusCode = response.response?.statusCode {
                    continuation.resume(
                        returning: .init(
                            data: data,
                            statusCode: statusCode,
                            metadata: response.toCAFUResponse(request.task)))
                }
            }
        }
    }
}

// MARK: UploadableNetworkProtocol

extension AlamofireManager: UploadableNetworkProtocol {
    public func upload<T: Decodable, U: Endpoint>(api: U, model: T.Type) -> ProgressResponse<T> {
        uploader.upload(api: api, model: model)
    }
}

// MARK: - Private Logic
extension AlamofireManager {
    /// Decides what Interceptor(s) an API call would need
    ///
    /// Having it behind a method helps in scaling logic to more than 1 Interceptor (Composite)
    /// - Note: For now, this only needs
    func getRequestInterceptor<T: Endpoint>(for api: T) -> RequestInterceptor? {
        api.authenticationRequired ? authenticator.interceptor : nil
    }
}

private extension Int {
    var isEmpty: Bool {
        [
            204
        ].contains(self)
    }
}
