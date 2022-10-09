//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import Foundation
import Entities
import CoreLocation
import ComposableCoreLocation
import ComposableArchitecture
import Business
import Entity
import Adhan
import RealmSwift
import Utils
import Localization
import GRDB

public struct PrayersClient {
	public func save(prayer: ANPrayer?) {
		guard let prayer = prayer else { return }
		do {
			try DatabaseService.dbQueue.write { db in
				var dao = try ANPrayerDAO.fetchOne(db, key: prayer.id)
				dao?.isDone = prayer.isDone
				try dao?.update(db)
			}
		} catch {
			fatalError()
		}
	}

	public func save(sunnah: ANSunnah?) {
		guard let sunnah = sunnah else { return }
		do {
			try DatabaseService.dbQueue.write { db in
				var dao = try ANSunnahDAO.fetchOne(db, key: sunnah.id)
				dao?.isDone = sunnah.isDone
				try dao?.update(db)
			}
		} catch {
			fatalError()
		}
	}

	public func save(zekr: ANAzkar?) {
		guard let zekr = zekr else { return }
		do {
			try DatabaseService.dbQueue.write { db in
				var dao = try ANAzkarDAO.fetchOne(db, key: zekr.id)
				dao?.currentCount = zekr.currentCount
				try dao?.update(db)
			}
		} catch {
			fatalError()
		}
	}

	public func prayers() -> [ANPrayer] {
		do {
			return try DatabaseService.dbQueue.read { db in
				
				return try (ANDayDAO.today.fetchOne(db)?.prayers.fetchAll(db))!.compactMap {
					$0.toDomainModel(
						sunnah: try $0.sunnah.fetchAll(db).map { $0.toDomainModel() },
						azkar: try $0.azkar.fetchAll(db).map { $0.toDomainModel() }
					)
				}
			}
		} catch {
			fatalError()
		}
	}

	public func getPrayingStreak() -> Int {
		60
	}

	public func getFaraaidDone() -> Int {
		do {
			return try DatabaseService.dbQueue.read { db in
				try ANPrayerDAO.filter(ANPrayerDAO.Columns.isDone == true).fetchCount(db)
			}
		} catch {
			fatalError()
		}
	}

	public func getSunnahsPrayed() -> Int {
		do {
			return try DatabaseService.dbQueue.read { db in
				try ANSunnahDAO.filter(ANSunnahDAO.Columns.isDone == true).fetchCount(db)
			}
		} catch {
			fatalError()
		}
	}

	public func getAzkarDoneCount() -> Int {
		do {
			return try DatabaseService.dbQueue.read { db in
				try ANAzkarDAO.filter(ANAzkarDAO.Columns.currentCount == 0).fetchCount(db)
			}
		} catch {
			fatalError()
		}
	}

	public func getSunnahPerDay() -> [(date: Date, count: Int)] {
		do {
			return try DatabaseService.dbQueue.read { db in
				try Date().previousWeek.map { date in
					try ANDayDAO
						.filter(ANDayDAO.Columns.date == date)
						.fetchAll(db)
						.compactMap { ($0.date, try $0.doneSunnah.fetchCount(db)) }
				}.flatMap { $0 }
			}
		} catch {
			fatalError()
		}
	}
}

class CurrentBundleFinder {}

extension Foundation.Bundle {
    
    static var prayersClientBundle: Bundle = {
        /* The name of your local package, prepended by "LocalPackages_" */
        let bundleName = "AlNajd_PrayersClient"
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            /* For command-line tools. */
            Bundle.main.bundleURL,
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
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
