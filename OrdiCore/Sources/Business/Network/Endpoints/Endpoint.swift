//
//  Endpoint.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Alamofire

public typealias HTTPHeaders = [String: String]
public typealias HTTPParameters = [String: Any]

/// A protocol that carries the request details for the network manager to use
///
///
/// We are encapsulating the logic of our APIs behind a protocol called Endpoint
/// this endpoint can be anything
/// it can be our own Endpoint enum that follows the same concept of Moya's TargetType
/// and we can also use it with any Networking Pod like Alamofire or Moya through
/// an adapter pattern if needed
public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: HTTPParameters { get }
    var encoding: ParametersEncoding { get }
    var method: HTTPMethod { get }
}

public extension Endpoint {
    /// Base URL for calling endpoints which is configurable according to Build
    /// Configurations
    var baseURL: String {
        return "https://api.dev.RS.tech/m/"
    }

    var headers: HTTPHeaders {
        defaultHeaders()
    }

    /// Defaults to JSONEncoding in case of POST, and URLEncoding GET
    /// Also Overridable in children in case of Composite Encoding or Irregular cases from the BE
    var encoding: ParametersEncoding {
        switch method {
        case .POST:
            return .jsonEncoding
        case .GET:
            return .urlEncoding
        }
    }

    // TODO: - Add Authorization when you come up with a good idea of how to handle the user
    func defaultHeaders() -> HTTPHeaders {
        return [
            "Accept-Language": "en",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
    }
}

/// Determines how the network manager will encode the parameters when firing the
/// request
public enum ParametersEncoding {
    /// Encodes the parameters as url query parameters
    case urlEncoding
    /// Encodes the parameters in the body of the request
    case jsonEncoding
    /// Encodes the parameters as a multipart form data and file data
    case multipartEncoding
}

/// HTTPMethods enum in String to ease generating Request and avoid switching and enjoy syntactic sugar
public enum HTTPMethod: String {
    case GET
    case POST
}
