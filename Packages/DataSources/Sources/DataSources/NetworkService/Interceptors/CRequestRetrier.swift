//
//  CRequestRetrier.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Configs
import Factory
import Foundation

// MARK: - CRequestRetrier

class CRequestRetrier: RequestInterceptor {
    private let retryLimit = Container.shared.networkConfig().retryLimit
    private let retryDelay = Container.shared.networkConfig().retryDelay
    private var currentRetryCount: Double = 1
    private var delayBetweenRetries: Double {
        (retryDelay * currentRetryCount) * Container.shared.networkConfig().retryDelayMultiplier
    }

    func retry(
        _ request: Request,
        for _: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void) {
        let isWithinRetryThreshold = request.retryCount < retryLimit
        let response = request.task?.response
        if response?.isServerError == true, isWithinRetryThreshold {
            completion(.retryWithDelay(delayBetweenRetries))
        } else {
            completion(.doNotRetryWithError(error))
        }
    }
}

private extension URLResponse {
    var isServerError: Bool {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else { return false }
        return (500...599).contains(statusCode)
    }
}
