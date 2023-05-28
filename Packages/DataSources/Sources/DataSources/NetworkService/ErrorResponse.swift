//
//  ValidationErrorModel.swift
//  CAFU
//
//  Created by Nermeen Tomoum on 27/09/2022.
//

import Foundation

// MARK: - ErrorResponse

public struct ErrorResponse: Decodable {
    public var message: String
    public var errorCode: ErrorCode?
    public var errors: [Message]?

    public enum ErrorCode: String, Decodable {
        case invalidOtp = "invalid_otp"
        case timeslotUnavailable = "timeslot_unavailable"
        case invalidNumber
        case generic = "generic_error"
        case notFound = "not_found"
        case smartcarTokenExpired = "vendor_token_expired"
        case unknownType
    }

    enum CodingKeys: CodingKey {
        case message
        case errorCode
        case errors
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        errorCode = try? container.decodeIfPresent(ErrorResponse.ErrorCode.self, forKey: .errorCode) ?? .unknownType
        errors = try container.decodeIfPresent([ErrorResponse.Message].self, forKey: .errors)
    }
}

// MARK: LocalizedError

extension ErrorResponse: LocalizedError {
    public var errorDescription: String? { message }
}

public extension ErrorResponse {
    // MARK: - ErrorModel
    struct Message: Decodable {
        var message: String?
        var source: Source?
    }

    // MARK: - SourceModel

    struct Source: Decodable {
        var pointer: String?
        var parameter: String?
        var header: String?
    }
}
