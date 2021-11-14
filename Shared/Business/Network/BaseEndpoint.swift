////
////  BaseEndpoint.swift
////  Al Najd (iOS)
////
////  Created by Ahmed Ramy on 05/11/2021.
////
//
//import Foundation
//import Moya
//
//// swiftlint:disable force_unwrapping
//
//public protocol BaseEndpoint: TargetType {}
//
//public extension BaseEndpoint {
//    var baseURL: URL {
//        URL(string: "https://api.pray.zone/v2/times/")!
//    }
//
//    var sampleData: Data {
////        .empty
//    }
//
//    var headers: [String: String]? {
//        var headers = [
//            "Accept-Language": "en",
//        ]
//
////        if let token = UserDefaultsService.shared.authToken {
//            headers["Authorization"] = token
//        }
//
//        return headers
//    }
//
//    var defaultParams: [String: Any] {
//        [:]
//    }
//}
