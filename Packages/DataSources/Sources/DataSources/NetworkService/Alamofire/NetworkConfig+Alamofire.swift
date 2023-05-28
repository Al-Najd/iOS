//
//  NetworkConfig+Alamofire.swift
//  CAFU
//
//  Created by Ahmed Ramy on 15/09/2022.
//

import Alamofire
import Configs
import Factory
import Foundation

// MARK: - NetworkConfig.Alamofire

extension NetworkConfig {
    enum Alamofire { }
}

extension NetworkConfig.Alamofire {
    static let config = Container.shared.networkConfig().sessionConfig
    static let session: Session = {
        Session(
            configuration: config,
            rootQueue: DispatchQueue(label: Container.shared.networkConfig().rootQueueID),
            interceptor: Interceptor(interceptors: [
                CRequestRetrier()
            ]),
            eventMonitors: [
                NetworkLogger()
            ])
    }()
}
