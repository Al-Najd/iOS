//
//  SmartcarExchangeEndpoint.swift
//  CAFU
//
//  Created by Ahmed Allam on 06/10/2022.
//

import Foundation

// MARK: - SmartcarEndpoint

public enum SmartcarEndpoint {
    case exchange(_ parameters: Encodable)
}

// MARK: Endpoint

extension SmartcarEndpoint: Endpoint {
    public var path: String {
        "connectivity/exchange"
    }

    public var task: EncodingTask {
        switch self {
        case .exchange(let parameters):
            return .body(parameters)
        }
    }

    public var method: HTTPMethod {
        .POST
    }

    public var authenticationRequired: Bool {
        true
    }

    public var requestTimeout: TimeInterval? {
        300.0
    }
}
