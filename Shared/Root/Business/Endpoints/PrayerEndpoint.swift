//
//  PrayerEndpoint.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 13/02/2022.
//

import Business

enum PrayerEndpoint {
  case monthlyTimes(country: String, city: String)
}

extension PrayerEndpoint: Endpoint {
  var baseURL: String {
    return "https://api.pray.zone/v2/times/"
  }
  
  var path: String {
    switch self {
    case .monthlyTimes:
      return "this_month.json"
    }
  }
  
  var parameters: HTTPParameters {
    switch self {
    case let .monthlyTimes(country, city):
      return [
        "country": country,
        "city": city
      ]
    }
  }
  
  var method: HTTPMethod {
    return .GET
  }
  
  var encoding: ParametersEncoding {
    return .urlEncoding
  }
}
