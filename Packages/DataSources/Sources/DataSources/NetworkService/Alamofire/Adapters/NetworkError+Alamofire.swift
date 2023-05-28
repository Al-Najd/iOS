//
//  NetworkError+Alamofire.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Foundation
import Loggers

extension AFError {
    func asNetworkError() -> NetworkError {
        switch self {
        case .explicitlyCancelled:
            return CancelledError()
        case .requestRetryFailed(let retryError, let originalError):
            let retryLoggableError = retryError.asAFError?.asNetworkError() ?? UnknownNetworkError(underlyingError: retryError)
            let originalLoggableError = retryError.asAFError?
                .asNetworkError() ?? UnknownNetworkError(underlyingError: originalError)

            return RetryFailureNetworkError(retryError: retryLoggableError, originalError: originalLoggableError)
        case .responseValidationFailed(let reason):
            return ResponseValidationNetworkError(reason: reason.asCAFUValidationReason())
        case .requestAdaptationFailed(let error):
            return mapRequestAdaptionErrors(error)
        default:
            Log.error(localizedDescription)
            return UnknownNetworkError()
        }
    }

    private func mapRequestAdaptionErrors(_ error: Error) -> NetworkError {
        guard let error = error as? Alamofire.AuthenticationError else {
            return UnknownNetworkError(underlyingError: error)
        }

        switch error {
        case .excessiveRefresh:
            return NetworkAuthError.excessiveRefresh
        case .missingCredential:
            return NetworkAuthError.missingCredentials
        }
    }
}

extension AFError.ResponseValidationFailureReason {
    func asCAFUValidationReason() -> ResponseValidationNetworkError.Reason {
        switch self {
        case .missingContentType(let acceptableContentTypes):
            return .missingContentType(acceptableContentTypes: acceptableContentTypes)
        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
            return .unacceptableContentType(
                acceptableContentTypes: acceptableContentTypes,
                responseContentType: responseContentType)
        default:
            return .unknown
        }
    }
}
