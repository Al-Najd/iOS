//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 01/04/2023.
//

import Foundation
import GRDB
import Entities
import Entity
import ComposableArchitecture

public struct AzkarClient {
    public func getMorningAzkar(for date: Date) -> [ANAzkar] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try ANDayDAO.Queries.getMorningAzkar(for: date).fetchOne(db)?.morningAzkar.fetchAll(db).compactMap {
                    $0.toDomainModel()
                } ?? []
            }
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }

    public func getNightAzkar(for date: Date) -> [ANAzkar] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try ANDayDAO.Queries.getNightAzkar(for: date).fetchOne(db)?.morningAzkar.fetchAll(db).compactMap {
                    $0.toDomainModel()
                } ?? []
            }
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }

    public func save(zekr: ANAzkar?) {
        guard let zekr else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try ANAzkarTimedDAO.fetchOne(db, key: zekr.id)
                dao?.repetation = zekr.repetation
                dao?.currentCount = zekr.currentCount
                dao?.isDone = zekr.isDone
                try dao?.update(db)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

extension AzkarClient: DependencyKey {
    public static let liveValue = AzkarClient()
}

public extension DependencyValues {
    var azkarDB: AzkarClient {
        get { self[AzkarClient.self] }
        set { self[AzkarClient.self] = newValue }
    }
}
