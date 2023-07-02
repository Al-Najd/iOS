//
//  File.swift
//
//
//  Created by Ahmed Ramy on 27/03/2023.
//

import Foundation
import GRDB

extension ANAzkarTimedDAO: FetchableRecord, MutablePersistableRecord {
    @discardableResult
    static func seedMorningAzkar(_ dayId: Int64, _ db: Database) throws -> [ANAzkarTimedDAO] {
        try Zekr
            .mainAzkar
            .filter { $0.category == .sabah }
            .compactMap { zekr in try zekr.toDAO(dayId).insertAndFetch(db) }
    }

    @discardableResult
    static func seedNightAzkar(_ dayId: Int64, _ db: Database) throws -> [ANAzkarTimedDAO] {
        try Zekr
            .mainAzkar
            .filter { $0.category == .masaa }
            .compactMap { zekr in try zekr.toDAO(dayId).insertAndFetch(db) }
    }
}
