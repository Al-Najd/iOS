////
////  PrayerEndpoint.swift
////  Al Najd (iOS)
////
////  Created by Ahmed Ramy on 05/11/2021.
////
//
//import Moya
//
//struct LocationInfo: Codable {
//  let longitude: Double
//  let latitude: Double
//}
//
//enum PrayerEndpoint {
//  case today(LocationInfo)
//}
//
//extension PrayerEndpoint: BaseEndpoint {
//  var path: String {
//    switch self {
//    case .today:
//      return "today.json"
//    }
//  }
//  
//  var method: Method {
//    switch self {
//    case .today:
//      return .get
//    }
//  }
//  
//  var task: Task {
//    switch self {
//    case .today(let info):
//      return .requestParameters(parameters: info.asDictionary(), encoding: URLEncoding.default)
//    }
//  }
//  
//  
//}
