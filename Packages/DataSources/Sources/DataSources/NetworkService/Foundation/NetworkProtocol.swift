//
//  NetworkProtocol.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import Combine
import Foundation

public typealias ProgressResponse<T> = AnyPublisher<Progress<T>, Error>

// MARK: - Progress

public enum Progress<T> {
    case loading(_ progress: Double)
    case finished(T)
}

// MARK: - NetworkProtocol

// sourcery: AutoMockable
public protocol NetworkProtocol {
    @discardableResult
    func call(api: Endpoint) async throws -> CAFUResponse
}

// MARK: - UploadableNetworkProtocol

public protocol UploadableNetworkProtocol {
    /// Used purely for downloading a file from the backend (could be an image, a specific file, etc)
    ///
    /// - Returns: a Publisher containing progress of the download, the parsed model after download finishes successfully & an error in case the stream errors out
    /// - Note: The file(s) uploading is handled when declaring the `Endpoint`, so when you send a file, this sending is handled inside the `Endpoint` enum
    /// - Note: Error always conforms to `NetworkError`
    func upload<T: Decodable, U: Endpoint>(api: U, model: T.Type) -> ProgressResponse<T>
}
