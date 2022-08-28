//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 28/08/2022.
//

import RealmSwift
import Foundation

public class ANPrayerDAO: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var name: String
    @Persisted public var isDone: Bool
    @Persisted public var sunnah: List<ANSunnahDAO>
    @Persisted public var azkar: List<ANAzkarDAO>
}

public class ANSunnahDAO: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var name: String
    @Persisted public var isDone: Bool
}

public class ANAzkarDAO: Object {
    @Persisted(primaryKey: true) public var id: String
    @Persisted public var name: String
    @Persisted public var currentCount: Int
}
