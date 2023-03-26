//
//  Adapter.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/11/2021.
//

import Entity
import Foundation

protocol AdapterProtocol {
    associatedtype Input
    associatedtype Output

    func adapt(_: Input) -> Output
}
