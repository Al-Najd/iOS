//
//  ParametersToMultipartFormDataAdapter.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 13/11/2021.
//

import Alamofire
import UIKit.UIImage

public struct ParametersToMultipartFormDataAdapter: AdapterProtocol {
    typealias Input = HTTPParameters
    typealias Output = MultipartFormData

    func adapt(_ input: Input) -> Output {
        guard let file = input["file"] as? ImageUploadRequest,
              let type = input["type"] as? String else { fatalError() }

        let multipart = MultipartFormData()
        multipart
            .append(
                file.data,
                withName: "file",
                fileName: file.fileName,
                mimeType: file.mimeType
            )

        multipart
            .append(
                type.data(using: .utf8) ?? Data(),
                withName: "type"
            )

        return multipart
    }
}

public struct ImageUploadRequest: Encodable {
    let fileName: String
    let data: Data
    let mimeType: String

    init(withImage image: UIImage) {
        mimeType = "image/png"
        fileName = "\(UUID().uuidString).png"
        data = image.pngData() ?? Data()
    }
}
