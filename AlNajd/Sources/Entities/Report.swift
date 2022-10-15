//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import Foundation

public enum Report { }

public extension Report {
    struct Daily: Equatable {
        public let date: Date
        public let prayers: [ANPrayer]
        
        public init(date: Date, prayers: [ANPrayer]) {
            self.date = date
            self.prayers = prayers
        }
    }
    
    struct Range: Equatable {
        public let ranges: [Date: [ANPrayer]]
        
        public init(ranges: [Date: [ANPrayer]]) {
            self.ranges = ranges
        }
    }
}
