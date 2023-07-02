//
//  File.swift
//
//
//  Created by Ahmed Ramy on 01/04/2023.
//

import Foundation
import GRDB


import ComposableArchitecture


// MARK: - AzkarClient

public struct AzkarService {
    public func getMorningAzkar(for date: Date) -> [Zekr] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.getDay(for: date).fetchOne(db)?.morningAzkar.fetchAll(db)
                    .compactMap { $0.toDomainModel() } ?? []
            }
        } catch {
            Log.error("""
                Failed to get Morning Azkar

                Error Description: \(error.debugDescription)
                """)
            return []
        }
    }

    public func getNightAzkar(for date: Date) -> [Zekr] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.getNightAzkar(for: date).fetchOne(db)?.morningAzkar.fetchAll(db).compactMap {
                    $0.toDomainModel()
                } ?? []
            }
        } catch {
            Log.error("""
                Failed to get Night Azkar

                Error Description: \(error.debugDescription)
                """)
            return []
        }
    }

    public func save(zekr: Zekr?) {
        guard let zekr else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try AzkarTimedDAO.fetchOne(db, key: zekr.id)
                dao?.repetation = zekr.repetation
                dao?.currentCount = zekr.currentCount
                dao?.isDone = zekr.isDone
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }
}

// MARK: DependencyKey

extension AzkarService: DependencyKey {
    public static let liveValue = AzkarService()
}

public extension DependencyValues {
    var azkarService: AzkarService {
        get { self[AzkarService.self] }
        set { self[AzkarService.self] = newValue }
    }
}
