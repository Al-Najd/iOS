//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 27/03/2023.
//

import Foundation
import GRDB

extension ANAzkarTimedDAO: FetchableRecord, MutablePersistableRecord {
    static let morning: () -> [ANAzkarTimedDAO] = {
        Zekr
            .mainAzkar
            .filter { $0.category == .sabah }
            .map { $0.toDAO() }
    }

    static let night: () -> [ANAzkarTimedDAO] = {
        Zekr
            .mainAzkar
            .filter { $0.category == .masaa }
            .map { $0.toDAO() }
    }
}
