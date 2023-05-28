//
//  Endpoint.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import Configs
import Factory
import Foundation

public typealias HTTPHeaders = [String: String]
public typealias HTTPParameters = [String: Any]

// MARK: - Endpoint

/// A protocol that carries the request details for the network manager to use
///
///
/// We are encapsulating the logic of our APIs behind a protocol called Endpoint
/// this endpoint can be anything
/// it can be our own Endpoint enum that follows the same concept of Moya's TargetType
/// and we can also use it with any Networking Pod like Alamofire or Moya through
/// an adapter pattern if needed
public protocol Endpoint {
    var id: String { get }
    var baseURL: String { get }
    var version: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var task: EncodingTask { get }
    var method: HTTPMethod { get }
    var authenticationRequired: Bool { get }
    /// if it has a value it will override the default timeout for the request in Alamofire
    var requestTimeout: TimeInterval? { get }
}

public extension Endpoint {
    /// Used in development to identify a request & mock its reponse using Postman
    ///
    /// - Note: It looks like this (`/auth/sign-in:POST`)
    /// - Requires: Development Build Config
    /// - SeeAlso: https://learning.postman.com/docs/designing-and-developing-your-api/mocking-data/matching-algorithm/
    var id: String {
        "/\(path):\(method.rawValue.uppercased())"
    }

    /// Base URL for calling endpoints which is configurable according to Build
    /// Configurations
    var baseURL: String {
        Container.shared.networkConfig().baseURL
    }

    var version: String {
        "v1"
    }

    var headers: HTTPHeaders {
        var headers = Container.shared.networkConfig().defaultHeaders

        switch method {
        case .POST,
             .PUT,
             .PATCH:
            headers["Content-Type"] = "application/json"
        default:
            break
        }

        return headers
    }

    var fullURL: String { baseURL + path }
    var requestTimeout: TimeInterval? { nil }
}

// MARK: - HTTPMethod

/// HTTPMethods enum in String to ease generating Request and avoid switching and enjoy syntactic sugar
public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

// MARK: - EncodingTask

public enum EncodingTask {
    case plain

    case body(Encodable)
    case url(Encodable)
    case composite(urlQueryParameters: Encodable, bodyParameters: Encodable)

    case uploadMultipart(parts: [MultipartFormData])
}

// MARK: - MultipartFormData

public struct MultipartFormData {
    let data: Data
    let name: String
    let fileName: String
    let mimeType: String
}
