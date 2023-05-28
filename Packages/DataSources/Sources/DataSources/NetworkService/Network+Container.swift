//
//  File.swift
//
//
//  Created by Ahmed Ramy on 30/03/2023.
//

import Factory
import Foundation

public extension Container {
    var network: Factory<NetworkProtocol> { self { AlamofireManager() }.shared }
}
