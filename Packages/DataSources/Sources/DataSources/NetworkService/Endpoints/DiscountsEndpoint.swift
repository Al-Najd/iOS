//
//  DiscountsEndpoint.swift
//  CAFU
//
//  Created by Ahmed Allam on 12/12/2022.
//

import Foundation

// MARK: - DiscountsEndpoint

public enum DiscountsEndpoint {
    case userDiscounts
}

// MARK: Endpoint

extension DiscountsEndpoint: Endpoint {
    public var path: String {
        "discounts"
    }

    public var task: EncodingTask {
        switch self {
        case .userDiscounts:
            return .plain
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .userDiscounts:
            return .GET
        }
    }

    public var authenticationRequired: Bool {
        true
    }
}
