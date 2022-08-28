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

public struct PrayersClient {
    let realm: Realm
    
    public init() {
        do {
            realm = try Realm(configuration: .init(deleteRealmIfMigrationNeeded: true))
            print(realm.configuration.fileURL)
            createDayIfNeeded()
        } catch {
            debugPrint(error)
            fatalError()
        }
    }
    
    public func save(prayer: ANPrayer?) {
        guard let dao = realm.object(ofType: ANPrayerDAO.self, forPrimaryKey: prayer.id) else { return }
        do {
            try realm.write {
                dao.isDone = prayer.isDone
            }
        } catch {
            debugPrint(error)
        }
    }
    
    public func save(sunnah: ANSunnah?) {
        guard let dao = realm.object(ofType: ANSunnahDAO.self, forPrimaryKey: sunnah.id) else { return }
        do {
            try realm.write {
                dao.isDone = sunnah.isDone
            }
        } catch {
            debugPrint(error)
        }
    }
    
    public func save(zekr: ANAzkar?) {
        guard let dao = realm.object(ofType: ANAzkarDAO.self, forPrimaryKey: zekr.id) else { return }
        do {
            try realm.write {
                dao.currentCount = zekr.currentCount
            }
        } catch {
            debugPrint(error)
        }
    }
    
    public func prayers(for date: Date = .now) -> [ANPrayer] {
        realm.object(ofType: ANDayDAO.self, forPrimaryKey: ANDayDAO.getID(from: date))?.prayers.compactMap { $0.toModel() } ?? []
    }
    
    private func createDayIfNeeded() {
        let date = Date.now
        let formattedDate = ANDayDAO.getID(from: date)
        guard realm.object(ofType: ANDayDAO.self, forPrimaryKey: formattedDate) == nil else { return }
        do {
            try realm.write {
                let day = ANDayDAO()
                day.id = formattedDate
                day.date = date
                day.prayers.append(objectsIn: ANPrayerDAO.faraaid)
                realm.add(day)
            }
        } catch {
            debugPrint(error)
        }
    }
}

public extension ANPrayerDAO {
    func toModel() -> ANPrayer {
        .init(
            id: id,
            name: name.localized,
            raqaat: raqaat,
            sunnah: .init(uniqueElements: sunnah.map { $0.toModel() }),
            afterAzkar: .init(uniqueElements: azkar.map { $0.toModel() }),
            isDone: isDone
        )
    }
}

public extension ANSunnahDAO {
    func toModel() -> ANSunnah {
        .init(
            id: id,
            name: name.localized,
            raqaat: raqaat,
            position: position,
            affirmation: affirmation,
            azkar: [],
            isDone: isDone
        )
    }
}

public extension ANAzkarDAO {
    func toModel() -> ANAzkar {
        .init(id: id, name: name.localized, reward: reward, repetation: repetation, currentCount: currentCount)
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
