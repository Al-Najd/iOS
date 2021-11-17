//
//  RSError.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 13/09/2021.
//

import UIKit

public struct RSError: Error, Codable {
    var code: ErrorCode?
    private var _text: String?
    var text: String? {
        get {
            code?.message ?? _text
        }

        set {
            _text = newValue
        }
    }

    init(code: ErrorCode?, text: String?) {
        self.code = code
        _text = text
    }
}

extension RSError {
    static var somethingWentWrong: RSError {
        RSError(code: nil, text: L10n.someThingWentWrong)
    }

    static var requestCancelled: RSError {
        RSError(code: .requestCancelled, text: "")
    }

    // TODO: - [Future] Localize -
    static var refreshTokenExpired: RSError {
        RSError(code: .refreshTokenExpired, text: "You must log in again...")
    }

    // TODO: - [Future] Localize -
    static var noNetworkOrTooWeak: RSError {
        RSError(code: .noNetworkOrTooWeak, text: "We can't detect a network, either because it's too weak or it's non-existent, most probably the signal?")
    }

    static var tokenExpired: RSError {
        RSError(code: .tokenExpired, text: "")
    }
}

public enum ErrorCode: String, Codable {
    case usernameAlreadyExist = "E0004"
    case emailAlreadyExist = "E0011"
    case userNameDoesntExist = "E0001"
    case emailAndPasswordDoesntMatch = "E0015"
    case userIsNotVerified = "E0022"
    case phoneAlreadyExist = "E0014"
    case emailNotValid = "E0009"
    case tokenExpired = "E00401"
    case refreshTokenExpired = "E00401X"
    case requestCancelled = "Cancelled"
    case noNetworkOrTooWeak = "No Network"

    var message: String? {
        switch self {
        case .userIsNotVerified:
            return L10n.emailNeedVerification
        case .emailAlreadyExist:
            return L10n.emailAlreadyExists
        case .phoneAlreadyExist:
            return L10n.phoneAlreadyExists
        case .usernameAlreadyExist:
            return L10n.usernameAlreadyExists
        case .userNameDoesntExist:
            return L10n.userNameDoesntExists
        case .emailNotValid:
            return L10n.emailNotValid
        case .emailAndPasswordDoesntMatch:
            return L10n.authErrorMessageEmailAndPasswordDoesntMatch
        default:
            return nil
        }
    }

    var isPresentable: Bool {
        switch self {
        case .requestCancelled,
             .tokenExpired:
            return false
        default:
            return true
        }
    }

    var loggable: Bool {
        loggingChannels.isEmpty == false
    }

    var loggingChannels: [LogEngine] {
        switch self {
        case .requestCancelled:
            return []
        default:
            return .all
        }
    }
}
