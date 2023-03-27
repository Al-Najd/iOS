//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 27/03/2023.
//

import Entities
import Foundation
import GRDB
import Utils

public struct ANAzkarTimedDAO: Codable {
    public var id: Int64?
    public var name: String
    public var reward: String
    public var repetation: Int
    public var time: Time
    public var currentCount: Int
    public var isDone: Bool { currentCount == .zero }

    init(id: Int64? = nil, name: String, reward: String, time: Time, repetation: Int) {
        self.id = id
        self.name = name
        self.reward = reward
        self.time = time
        self.repetation = repetation
        self.currentCount = repetation
    }
}

public extension ANAzkarTimedDAO {
    enum Time: Int, Codable, DatabaseValueConvertible {
        case day
        case night
    }
}
