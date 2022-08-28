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

public struct PrayersClient {
    let realm: Realm
    private let seedURL: URL? = Bundle.prayersClientBundle.url(forResource: "seed", withExtension: ".realm")
    
    public init() {
        do {
            realm = try Realm(configuration: .init(deleteRealmIfMigrationNeeded: true, seedFilePath: seedURL))
        } catch {
            fatalError()
        }
    }
    
    public func save(prayer: ANPrayer) {
        do {
            try realm.write {
                realm.add(prayer.toDAO(), update: .modified)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    public func prayer(for id: ANPrayer.ID) -> ANPrayerDAO? {
        realm.object(ofType: ANPrayerDAO.self, forPrimaryKey: id)
    }
}

public extension ANPrayer {
    func toDAO() -> ANPrayerDAO {
        let dao = ANPrayerDAO()
        dao.id = self.id
        dao.name = self.name
        dao.isDone = self.isDone
        dao.sunnah.append(objectsIn: self.sunnah.elements.map { $0.toDAO() })
        dao.azkar.append(objectsIn: self.afterAzkar.elements.map { $0.toDAO() })
        return dao
    }
    
    mutating func update(from dao: ANPrayerDAO?) {
        guard let dao = dao else { return }
        isDone = dao.isDone
        dao.sunnah.elements.forEach { sunnah[id: $0.id]?.update(from: $0) }
        dao.azkar.elements.forEach { afterAzkar[id: $0.id]?.update(from: $0) }
    }
}

public extension ANSunnah {
    func toDAO() -> ANSunnahDAO {
        let dao = ANSunnahDAO()
        dao.id = self.id
        dao.name = self.name
        dao.isDone = self.isDone
        return dao
    }
    
    mutating func update(from dao: ANSunnahDAO?) {
        guard let dao = dao else { return }
        isDone = dao.isDone
    }
}

public extension ANAzkar {
    func toDAO() -> ANAzkarDAO {
        let dao = ANAzkarDAO()
        dao.id = self.id
        dao.name = self.name
        dao.currentCount = self.currentCount
        return dao
    }
    
    mutating func update(from dao: ANAzkarDAO?) {
        guard let dao = dao else { return }
        currentCount = dao.currentCount
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
