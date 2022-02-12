//
//  GIDSignInErrorToOErrorAdapter.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 16/11/2021.
//

//import Foundation
import Entity
//import GoogleSignIn
//
//public struct GIDSignInErrorToOErrorAdapter: AdapterProtocol {
//    typealias Input = GIDSignInError
//    typealias Output = OError
//
//    func adapt(_ error: GIDSignInError) -> OError {
//        switch error._nsError.code {
//        /// Indicates an unknown error has occurred.
//        case -1:
//            return .somethingWentWrong
//        /// Indicates a problem reading or writing to the application keychain.
//        case -2:
//            return .somethingWentWrong
//        /// Indicates there are no valid auth tokens in the keychain. This error code will be returned by
//        /// `restorePreviousSignIn` if the user has not signed in before or if they have since signed out.
//        case -4:
//            return .refreshTokenExpired
//        /// Indicates the user canceled the sign in request.
//        case -5:
//            return .requestCancelled
//        /// Indicates an Enterprise Mobility Management related error has occurred.
//        case -6:
//            return .somethingWentWrong
//        /// Indicates there is no `currentUser`.
//        case -7:
//            return .refreshTokenExpired
//        /// Indicates the requested scopes have already been granted to the `currentUser`.
//        case -8:
//            return .somethingWentWrong
//        default:
//            return .somethingWentWrong
//        }
//    }
//}
