//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/08/2022.
//

import RealmSwift
import Foundation
import Entities

public class ANDayDAO: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var date: Date
    @Persisted public var prayers: List<ANPrayerDAO>
    
    static func getID(from date: Date) -> String {
        "\(date.startOfDay.day)-\(date.startOfDay.month)-\(date.startOfDay.year)"
    }
}

public class ANPrayerDAO: Object {
    @Persisted(primaryKey: true) public var id: UUID
    @Persisted public var name: String
    @Persisted public var isDone: Bool
    @Persisted public var sunnah: List<ANSunnahDAO>
    @Persisted public var azkar: List<ANAzkarDAO>
    @Persisted public var raqaat: Int
    
    public static var faraaid: [ANPrayerDAO] = [
        .fajr,
        .dhuhr,
        .asr,
        .maghrib,
        .isha
    ]
}

public extension ANPrayerDAO {
    static let fajr: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Fajr"
        $0.raqaat = 2
        $0.sunnah.append(objectsIn: [.fajrSunnah])
    }
    
    static let dhuhr: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Duhr"
        $0.raqaat = 4
        $0.sunnah.append(objectsIn: [.dhuhrBeforeSunnah, .dhuhrAfterSunnah, .dhuhrAfterMostahabSunnah])
    }
    
    static let asr: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Aasr"
        $0.raqaat = 4
        $0.sunnah.append(objectsIn: [])
    }
    
    static let maghrib: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Maghrib"
        $0.raqaat = 3
        $0.sunnah.append(objectsIn: [.maghribBeforeMostahabSunnah, .maghribAfterSunnah])
    }
    
    static let isha: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Aishaa"
        $0.raqaat = 4
        $0.sunnah.append(objectsIn: [.ishaaBeforeMostahabSunnah, .ishaaAfterSunnah])
    }
}

public class ANSunnahDAO: Object {
    @Persisted(primaryKey: true) public var id: UUID
    @Persisted public var name: String
    @Persisted public var isDone: Bool
    @Persisted public var raqaat: Int
    @Persisted public var position: ANSunnah.Position
    @Persisted public var affirmation: ANSunnah.Affirmation
}

extension ANSunnahDAO {
    static let fajrSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Fajr"
        $0.raqaat = 2
        $0.position = .before
        $0.affirmation = .affirmed
    }
    
    static let dhuhrBeforeSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Duhr"
        $0.raqaat = 4
        $0.position = .before
        $0.affirmation = .affirmed
    }
    
    static let dhuhrAfterSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Duhr"
        $0.raqaat = 2
        $0.position = .after
        $0.affirmation = .affirmed
    }
    
    static let dhuhrAfterMostahabSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Duhr"
        $0.raqaat = 2
        $0.position = .after
        $0.affirmation = .desirable
    }
    
    static let maghribBeforeMostahabSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Maghrib"
        $0.raqaat = 2
        $0.position = .before
        $0.affirmation = .desirable
    }
    
    static let maghribAfterSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Maghrib"
        $0.raqaat = 2
        $0.position = .after
        $0.affirmation = .affirmed
    }
    
    static let ishaaBeforeMostahabSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Aishaa"
        $0.raqaat = 2
        $0.position = .before
        $0.affirmation = .desirable
    }
    
    static let ishaaAfterSunnah: ANSunnahDAO = ANSunnahDAO().then {
        $0.name = "Aishaa"
        $0.raqaat = 2
        $0.position = .after
        $0.affirmation = .affirmed
    }
}

public class ANAzkarDAO: Object {
    @Persisted(primaryKey: true) public var id: UUID
    @Persisted public var name: String
    @Persisted public var reward: String
    @Persisted public var repetation: Int
    @Persisted public var currentCount: Int
}
