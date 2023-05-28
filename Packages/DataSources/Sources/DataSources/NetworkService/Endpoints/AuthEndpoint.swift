//
//  AuthEndpoint.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/12/2022.
//

import Foundation

// MARK: - AuthEndpoint

public enum AuthEndpoint {
    case refreshToken(Encodable)
    case requestOTP(Encodable)
    case verifyOTP(Encodable)
    case logout(Encodable)
}

// MARK: Endpoint

extension AuthEndpoint: Endpoint {
    public var path: String {
        switch self {
        case .refreshToken:
            return "auth/token"
        case .requestOTP:
            return "auth/passwordless/otp"
        case .verifyOTP:
            return "auth/token"
        case .logout:
            return "logout"
        }
    }

    public var task: EncodingTask {
        switch self {
        case .refreshToken(let request),
             .verifyOTP(let request),
             .requestOTP(let request),
             .logout(let request):
            return .body(request)
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .refreshToken,
             .requestOTP,
             .verifyOTP,
             .logout:
            return .POST
        }
    }

    public var authenticationRequired: Bool {
        switch self {
        case .refreshToken,
             .requestOTP,
             .verifyOTP:
            return false
        case .logout:
            return true
        }
    }
}
