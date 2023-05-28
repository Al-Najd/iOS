//
//  AddressesEndpoint.swift
//  CAFU
//
//  Created by Ahmed Ramy on 30/01/2023.
//

import Foundation

// MARK: - AddressesEndpoint

public enum AddressesEndpoint {
    case zones
}

// MARK: Endpoint

extension AddressesEndpoint: Endpoint {
    public var path: String {
        switch self {
        case .zones:
            return "addresses/zones?service=ev"
        }
    }

    public var task: EncodingTask {
        switch self {
        case .zones:
            return .plain
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .zones:
            return .GET
        }
    }

    public var authenticationRequired: Bool {
        switch self {
        case .zones:
            return true
        }
    }
}
