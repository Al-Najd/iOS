//
//  File.swift
//
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import ComposableArchitecture
import Foundation
import GRDB

// MARK: - PrayersClient

public struct PrayersClient {
    public func save(nafila: Nafila?) {
        guard let nafila = nafila else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try ANNafilaDAO.fetchOne(db, key: nafila.id)
                dao?.isDone = nafila.isDone
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func save(prayer: Prayer?) {
        guard let prayer = prayer else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try ANPrayerDAO.fetchOne(db, key: prayer.id)
                dao?.isDone = prayer.isDone
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func save(sunnah: Sunnah?) {
        guard let sunnah = sunnah else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try ANSunnahDAO.fetchOne(db, key: sunnah.id)
                dao?.isDone = sunnah.isDone
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func save(zekr: Zekr?) {
        guard let zekr = zekr else { return }
        do {
            try DatabaseService.dbQueue.write { db in
                var dao = try AzkarDAO.fetchOne(db, key: zekr.id)
                dao?.currentCount = zekr.currentCount
                try dao?.update(db)
            }
        } catch {
            Log.error(error.localizedDescription)
        }
    }

    public func nafila(for date: Date) -> [Nafila] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try (DayDAO.Queries.getNafila(for: date).fetchOne(db)?.nafila.fetchAll(db))!.compactMap {
                    $0.toDomainModel()
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func prayers(for date: Date) -> [Prayer] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.getPrayers(for: date).fetchOne(db)?.prayers.fetchAll(db).compactMap {
                    $0.toDomainModel(
                        sunnah: try $0.sunnah.fetchAll(db).map { $0.toDomainModel() },
                        azkar: try $0.azkar.fetchAll(db).map { $0.toDomainModel() })
                } ?? []
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func todayPrayers() -> [Prayer] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.todayPrayers.fetchAll(db).compactMap {
                    $0.toDomainModel(
                        sunnah: try $0.sunnah.fetchAll(db).map { $0.toDomainModel() },
                        azkar: try $0.azkar.fetchAll(db).map { $0.toDomainModel() })
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }

    public func getPrayingStreak() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                // Get days from today till days where streak was broken
                let days = try DayDAO.Queries.beforeToday.including(all: DayDAO.prayers).all().fetchAll(db)
                let daysWithFullPrayers = try days.filter { try $0.missedPrayers.isEmpty(db) != false }
                return daysWithFullPrayers.count
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getFaraaidDone() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                try ANPrayerDAO.filter(ANPrayerDAO.Columns.isDone == true).fetchCount(db)
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getSunnahsPrayed() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                try ANSunnahDAO.filter(ANSunnahDAO.Columns.isDone == true).fetchCount(db)
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getAzkarDoneCount() -> Int {
        do {
            return try DatabaseService.dbQueue.read { db in
                try AzkarDAO.filter(AzkarDAO.Columns.currentCount == 0).fetchCount(db)
            }
        } catch {
            Log.error(error.localizedDescription)
            return 0
        }
    }

    public func getSunnahPerDay() -> [(date: Date, count: Int)] {
        do {
            return try DatabaseService.dbQueue.read { db in
                try DayDAO.Queries.previousWeek.fetchAll(db).compactMap {
                    ($0.date, try $0.doneSunnah.fetchCount(db))
                }
            }
        } catch {
            Log.error(error.localizedDescription)
            return []
        }
    }
}

// MARK: DependencyKey

extension PrayersClient: DependencyKey {
    public static let liveValue = PrayersClient()
}

public extension DependencyValues {
    var prayersDB: PrayersClient {
        get { self[PrayersClient.self] }
        set { self[PrayersClient.self] = newValue }
    }
}

extension Foundation.Bundle {
    static var prayersClientBundle: Bundle = {
        // The name of your local package, prepended by "LocalPackages_"
        let bundleName = "AlNajd_PrayersClient"
        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,
            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            // For command-line tools.
            Bundle.main.bundleURL,
            // Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/").
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}
