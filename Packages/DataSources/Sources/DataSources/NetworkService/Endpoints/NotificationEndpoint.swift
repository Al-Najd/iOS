//
//  NotificationEndPoint.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 27/09/2022.
//

import Foundation

// MARK: - NotificationEndpoint

public enum NotificationEndpoint {
    case register(_ parameters: Encodable)
}

// MARK: Endpoint

extension NotificationEndpoint: Endpoint {
    public var path: String {
        "push/devices"
    }

    public var task: EncodingTask {
        switch self {
        case .register(let parameters):
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
