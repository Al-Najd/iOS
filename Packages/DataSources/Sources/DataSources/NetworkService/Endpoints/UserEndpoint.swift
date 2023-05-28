//
//  UserEndpoint.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 07/11/2022.
//

import Foundation

// MARK: - UserEndpoint

public enum UserEndpoint {
    case getUser
    case update(user: Encodable)
    case deleteUser
}

// MARK: Endpoint

extension UserEndpoint: Endpoint {
    public var path: String {
        "me"
    }

    public var task: EncodingTask {
        switch self {
        case .getUser:
            return .plain
        case .update(let parameters):
            return .body(parameters)
        case .deleteUser:
            return .plain
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .getUser:
            return .GET
        case .update:
            return .PATCH
        case .deleteUser:
            return .DELETE
        }
    }

    public var authenticationRequired: Bool {
        true
    }
}
