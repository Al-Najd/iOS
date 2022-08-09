//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import ComposableArchitecture
import Entities

struct HomeFeature: Equatable {
    public var prayers: [ANPrayer]
    
    public init(prayers: [ANPrayer] = .faraaid) {
        self.prayers = prayers
    }
}
