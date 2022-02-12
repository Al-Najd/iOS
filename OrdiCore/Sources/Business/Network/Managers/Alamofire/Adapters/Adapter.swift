//
//  Adapter.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Foundation
import Entity

protocol AdapterProtocol {
    associatedtype Input
    associatedtype Output

    func adapt(_: Input) -> Output
}
