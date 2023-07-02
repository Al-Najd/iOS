//
//  NetworkProtocol.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 03/11/2021.
//

import Combine

import Foundation

public typealias RSExpected<T> = Result<T, OError>
public typealias RSHandler<T> = (RSExpected<T>) -> Void
public typealias RSResponse<T: Codable> = AnyPublisher<T, OError>
public typealias RSResponseWithProgress<T: Codable> = RSResponse<RSProgressResponse<T>>

// MARK: - RSProgressResponse

public enum RSProgressResponse<T: Codable>: Codable {
    case loading(Double)
    case finished(T)
}

// MARK: - NetworkProtocol

public protocol NetworkProtocol {
    func call<T: Codable, U: Endpoint>(api: U, model: T.Type) -> RSResponse<T>
    func upload<T: Codable, U: Endpoint>(api: U, model: T.Type) -> RSResponseWithProgress<T>
}
