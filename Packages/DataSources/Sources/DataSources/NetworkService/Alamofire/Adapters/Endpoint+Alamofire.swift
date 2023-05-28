//
//  Endpoint+Alamofire.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/09/2022.
//

import Alamofire
import Foundation

// MARK: - AlamofireRequest

extension Endpoint {
    func addParts(to formData: Alamofire.MultipartFormData) {
        switch task {
        case .uploadMultipart(let parts):
            parts.forEach {
                formData.append($0.data, withName: $0.name, fileName: $0.fileName, mimeType: $0.mimeType)
            }
        default:
            // If you got here, it's a good idea to check if you're calling a multipart correctly or not
            assertionFailure("Requesting Multipart Data with in-correct task, (task: \(task))")
        }
    }
}
