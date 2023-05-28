//
//  DataResponse.swift
//  CAFU
//
//  Created by Ahmed Allam on 16/12/2022.
//

import Foundation

// MARK: - DataResponse

public struct DataResponse<T: Decodable>: Decodable {
    public let data: T
}

// MARK: Encodable

extension DataResponse: Encodable where T: Encodable { }
