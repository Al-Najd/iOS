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
        public let prayers: [DeedCategory: [Deed]]
        public let azkar: [AzkarCategory: [RepeatableDeed]]
        
        public init(date: Date, prayers: [DeedCategory : [Deed]], azkar: [AzkarCategory : [RepeatableDeed]]) {
            self.date = date
            self.prayers = prayers
            self.azkar = azkar
        }
    }
    
    struct Range: Equatable {
        public let range: [DeedCategory: [Date: [Deed]]]
        
        public init(range: [DeedCategory : [Date : [Deed]]]) {
            self.range = range
        }
    }
}
