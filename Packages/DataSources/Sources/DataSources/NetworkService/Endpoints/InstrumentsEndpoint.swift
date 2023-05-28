//
//  PaymentEndpoint.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 07/11/2022.
//

import Foundation

// MARK: - InstrumentsEndpoint

public enum InstrumentsEndpoint {
    case add(_ parameters: Encodable)
}

// MARK: Endpoint

extension InstrumentsEndpoint: Endpoint {
    public var path: String {
        "payments/instruments"
    }

    public var task: EncodingTask {
        switch self {
        case .add(let parameters):
            return .body(parameters)
        }
    }

    public var method: HTTPMethod {
        .POST
    }

    public var authenticationRequired: Bool {
        true
    }
}
