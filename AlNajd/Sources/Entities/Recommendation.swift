//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 03/02/2022.
//

import Foundation

public struct Recommendation: Equatable {
    let title: String
    let subtitle: String
    
    public init(
        title: String,
        subtitle: String
    ) {
        self.title = title
        self.subtitle = subtitle
    }
}
