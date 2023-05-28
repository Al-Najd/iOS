//
//  CAFUResponse+Alamofire.swift
//  CAFU
//
//  Created by Ahmed Ramy on 16/09/2022.
//

import Alamofire
import Foundation

extension AFDataResponse {
    func toCAFUResponse(_ task: URLSessionTask? = nil) -> CAFUResponse.Metadata {
        .init(request: request, response: response, task: task)
    }
}
