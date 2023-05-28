//
//  AssetsEndpoint.swift
//  CAFU
//
//  Created by Adithi Bolar on 10/10/2022.
//

import Foundation

// MARK: - AssetsEndpoint

public enum AssetsEndpoint {
    case listEvAssets
}

// MARK: Endpoint

extension AssetsEndpoint: Endpoint {
    public var path: String {
        "assets/evs"
    }

    public var task: EncodingTask {
        .plain
    }

    public var method: HTTPMethod {
        .GET
    }

    public var authenticationRequired: Bool {
        true
    }
}
