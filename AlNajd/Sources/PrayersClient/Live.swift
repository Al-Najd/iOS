//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import Foundation
import ComposableArchitecture
import Business
import Entities

extension PrayersClient {
    public static let live = PrayersClient(prayers: { request in
        return AlamofireManager.main.call(
                api: PrayersEndpoint.thisMonth(lat: request.latitude, long: request.longitude),
                model: PrayerScheduleResponse.self
            ).eraseToEffect()
    })
}

enum PrayersEndpoint {
    case thisMonth(lat: Double, long: Double)
}

extension PrayersEndpoint: Endpoint {
    var baseURL: String {
        "https://api.pray.zone/v2/times/"
    }
    
    var path: String {
        switch self {
            case .thisMonth:
                return "this_month.json"
        }
    }
    
    var parameters: HTTPParameters {
        switch self {
            case let .thisMonth(lat, long):
                return [
                    "longitude" : long,
                    "latitude": lat
                ]
        }
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var encoding: ParametersEncoding {
        .urlEncoding
    }
}
