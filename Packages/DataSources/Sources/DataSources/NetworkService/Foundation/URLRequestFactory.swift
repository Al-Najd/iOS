//
//  URLRequestFactory.swift
//  CAFU
//
//  Created by Ahmed Ramy on 12/09/2022.
//

import Foundation

enum URLRequestFactory {
    /// Generates URL out of endpoint protocol
    /// - Parameter endpoint: the protocol that carries the details of the request
    /// - Returns: the URL to be used to build the URLRequest
    private static func generateURL(outOf endpoint: Endpoint) -> URL {
        guard let url = URL(string: endpoint.fullURL) else {
            // We used a fatalError here with a helpful message so that if we had a
            // typo in the path or the baseURL, this fatalError notifies us, Normally
            // i'd go for an assertionFailure so it doesn't crash the app in
            // production, but since am sure this won't happen in production but only
            // in development, so I don't see anything wrong with it
            fatalError("You probably passed a wrong URL,\n check \(endpoint.baseURL) or \(endpoint.path)")
        }
        return url
    }

    /// Encodes the parameters in the URL
    private static func encodeParametersInURL(in urlRequest: inout URLRequest, parameters: Encodable) {
        guard let url = urlRequest.url?.absoluteString else { return }
        guard var urlComponents = URLComponents(string: url) else { return }
        urlComponents.queryItems = parameters.asDictionary().map { key, value in
            URLQueryItem(name: key, value: value as? String ?? "")
        }

        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        urlRequest.url = urlComponents.url
    }

    /// Encodes the parameters in the Request Body
    private static func encodeParametersInBodyOfRequest(in request: inout URLRequest, parameters: Encodable) {
        request.httpBody = try? parameters.encode()
    }

    /// Handles How the parameters will be encoded according to the endpoint encoding
    private static func encodeRequestWithParameters(_ request: inout URLRequest, from endpoint: Endpoint) {
        switch endpoint.task {
        case .plain:
            break
        case .url(let parameters):
            encodeParametersInURL(in: &request, parameters: parameters)
        case .body(let parameters):
            encodeParametersInBodyOfRequest(in: &request, parameters: parameters)
        case .composite(let urlQueryParameters, let bodyParameters):
            encodeParametersInURL(in: &request, parameters: urlQueryParameters)
            encodeParametersInBodyOfRequest(in: &request, parameters: bodyParameters)
        default:
            assertionFailure("\(endpoint.task) is not handleable in parameters")
        }
    }

    /// Generates URLRequest after building the URL, injecting the method and the headers
    /// and encoding the Parameters suitably according to the endpoint
    /// - Parameter endpoint: the protocol that carries the details of the request
    /// - Returns: URLRequest for the manager to use
    static func generateRequest(outOf endpoint: Endpoint) -> URLRequest {
        let url = generateURL(outOf: endpoint)
        var urlRequest = URLRequest(url: url)
        // override request timeout if endpoint.requestTimeout has value
        if let timeout = endpoint.requestTimeout {
            urlRequest.timeoutInterval = timeout
        }
        urlRequest.httpMethod = endpoint.method.rawValue

        endpoint.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        encodeRequestWithParameters(&urlRequest, from: endpoint)

        return urlRequest
    }
}
