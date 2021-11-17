//
//  ASAuthorizationErrorToRSError.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 16/11/2021.
//

import AuthenticationServices
import Foundation

public struct ASAuthorizationErrorToRSError: AdapterProtocol {
    typealias Input = ASAuthorizationError
    typealias Output = RSError

    func adapt(_ error: ASAuthorizationError) -> RSError {
        switch error._nsError.code {
        case ASAuthorizationError.Code.canceled.rawValue:
            return .requestCancelled
        default:
            return .somethingWentWrong
        }
    }
}
