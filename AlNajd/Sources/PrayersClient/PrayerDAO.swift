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
        $0.azkar.append(objectsIn: ANAzkarDAO.common + [.laIlahIlaAllahWahdah, .alKursiFajrMaghrib, .alIkhlasFajrMaghrib, .alFalaqFajrMaghrib, .alNasFajrMaghrib])
    }
    
    static let dhuhr: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Duhr"
        $0.raqaat = 4
        $0.sunnah.append(objectsIn: [.dhuhrBeforeSunnah, .dhuhrAfterSunnah, .dhuhrAfterMostahabSunnah])
        $0.azkar.append(objectsIn: ANAzkarDAO.common + [.alKursi, .alIkhlas, .alFalaq, .alNas])
    }
    
    static let asr: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Aasr"
        $0.raqaat = 4
        $0.sunnah.append(objectsIn: [])
        $0.azkar.append(objectsIn: ANAzkarDAO.common + [.alKursi, .alIkhlas, .alFalaq, .alNas])
    }
    
    static let maghrib: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Maghrib"
        $0.raqaat = 3
        $0.sunnah.append(objectsIn: [.maghribBeforeMostahabSunnah, .maghribAfterSunnah])
        $0.azkar.append(objectsIn: ANAzkarDAO.common + [.laIlahIlaAllahWahdah, .alKursiFajrMaghrib, .alIkhlasFajrMaghrib, .alFalaqFajrMaghrib, .alNasFajrMaghrib])
    }
    
    static let isha: ANPrayerDAO = ANPrayerDAO().then {
        $0.name = "Aishaa"
        $0.raqaat = 4
        $0.sunnah.append(objectsIn: [.ishaaBeforeMostahabSunnah, .ishaaAfterSunnah])
        $0.azkar.append(objectsIn: ANAzkarDAO.common + [.alKursi, .alIkhlas, .alFalaq, .alNas])
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

extension ANAzkarDAO {
    static let common: [ANAzkarDAO] = [
        .estigphar,
        .antAlSalam,
        .mokhlseenLahoLDeen,
        .laManiaaLemaAatyt,
        .subhanAllah,
        .alhamdulellah,
        .allahuAkbar,
        .laIlahIlaAllah,
        .laIlahIlaAllahLaHawlWalaQwataIlaBellah
    ]
    
    static let estigphar = ANAzkarDAO().then {
        $0.name = "estigphar"
        $0.repetation = 3
        $0.currentCount = 3
    }
    
    static let antAlSalam = ANAzkarDAO().then {
        $0.name = "ant_al_salam"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let laIlahIlaAllahWahdah = ANAzkarDAO().then {
        $0.name = "la_ilah_ila_allah_wahdah"
        $0.reward = "la_ilah_ila_allah_wahdah_reward"
        $0.repetation = 10
        $0.currentCount = 10
    }
    
    static let mokhlseenLahoLDeen = ANAzkarDAO().then {
        $0.name = "mokhlseen_laho_l_deen"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let laManiaaLemaAatyt = ANAzkarDAO().then {
        $0.name = "la_mani3_lema_a3tyt"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let subhanAllah = ANAzkarDAO().then {
        $0.name = "subhan_allah"
        $0.repetation = 33
        $0.currentCount = 33
    }
    
    static let alhamdulellah = ANAzkarDAO().then {
        $0.name = "alhamdulellah"
        $0.repetation = 33
        $0.currentCount = 33
    }
    
    static let allahuAkbar = ANAzkarDAO().then {
        $0.name = "allahuakbar"
        $0.repetation = 33
        $0.currentCount = 33
    }
    
    static let laIlahIlaAllah = ANAzkarDAO().then {
        $0.name = "la_ilah_ila_allah"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let laIlahIlaAllahLaHawlWalaQwataIlaBellah = ANAzkarDAO().then {
        $0.name = "la_ilah_ila_allah_la_hawl_wala_qwata_ila_bellah"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let alKursi = ANAzkarDAO().then {
        $0.name = "ayat_al_kursi"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let alIkhlas = ANAzkarDAO().then {
        $0.name = "ayat_al_ikhlas"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let alFalaq = ANAzkarDAO().then {
        $0.name = "ayat_al_falaq"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let alNas = ANAzkarDAO().then {
        $0.name = "ayat_al_alnas"
        $0.repetation = 1
        $0.currentCount = 1
    }
    
    static let alKursiFajrMaghrib = ANAzkarDAO().then {
        $0.name = "ayat_al_kursi"
        $0.repetation = 3
        $0.currentCount = 3
    }
    
    static let alIkhlasFajrMaghrib = ANAzkarDAO().then {
        $0.name = "ayat_al_ikhlas"
        $0.repetation = 3
        $0.currentCount = 3
    }
    
    static let alFalaqFajrMaghrib = ANAzkarDAO().then {
        $0.name = "ayat_al_falaq"
        $0.repetation = 3
        $0.currentCount = 3
    }
    
    static let alNasFajrMaghrib = ANAzkarDAO().then {
        $0.name = "ayat_al_alnas"
        $0.repetation = 3
        $0.currentCount = 3
    }
}
