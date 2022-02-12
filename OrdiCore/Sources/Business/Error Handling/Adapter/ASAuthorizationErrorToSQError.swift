//
//  ASAuthorizationErrorToOError.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 16/11/2021.
//

import AuthenticationServices

import Foundation
import Entity

public struct ASAuthorizationErrorToOError: AdapterProtocol {
    typealias Input = ASAuthorizationError
    typealias Output = OError

    func adapt(_ error: ASAuthorizationError) -> OError {
        switch error._nsError.code {
        case ASAuthorizationError.Code.canceled.rawValue:
            return .requestCancelled
        default:
            return .somethingWentWrong
        }
    }
}
