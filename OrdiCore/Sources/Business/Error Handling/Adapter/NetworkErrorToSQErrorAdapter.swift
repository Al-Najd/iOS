//
//  NetworkErrorToOErrorAdapter.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Alamofire
import Foundation
import Entity
import OrdiLogging

public struct NetworkErrorToOErrorAdapter: AdapterProtocol {
    typealias Input = Error
    typealias Output = OError

    func adapt(_ error: Error) -> OError {
        switch error {
        case URLError.unknown:
            return .somethingWentWrong
        case URLError.cancelled, AFError.explicitlyCancelled:
            return .requestCancelled
        case URLError.networkConnectionLost:
            return .noNetworkOrTooWeak
        case URLError.notConnectedToInternet:
            return .noNetworkOrTooWeak
        case let AFError.multipartEncodingFailed(reason: reason):
            LoggersManager.error(message: "\(reason)")
            return .somethingWentWrong

        default:
            return .somethingWentWrong
        }
    }
}
