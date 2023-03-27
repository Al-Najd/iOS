//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 27/03/2023.
//

import Foundation

// MARK: - Zekr

struct Zekr: Codable {
    let category: Category
    let count: Int
    let purpose: String
    let reference: String
    let zekr: String

    enum CodingKeys: String, CodingKey {
        case category, count
        case purpose = "description"
        case reference, zekr
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decode(Category.self, forKey: .category)
        count = Int(try values.decode(String.self, forKey: .count)) ?? 0
        purpose = try values.decode(String.self, forKey: .purpose)
        reference = try values.decode(String.self, forKey: .reference)
        zekr = try values.decode(String.self, forKey: .zekr)
    }

    func encode(to _: Encoder) throws {
        fatalError()
    }

    static var mainAzkar: [Zekr] = {
        let decoder = JSONDecoder()
        do {
            guard let url = Bundle.module.url(forResource: "azkar-db", withExtension: "json") else { return [] }
            let data = try Data(contentsOf: url)
            let azkar = try decoder
                .decode(FailableCodableArray<Zekr>.self, from: data)
                .elements
            return azkar
        } catch {
            debugPrint(error)
            return []
        }
    }()
}

// MARK: Zekr.Category

extension Zekr {
    enum Category: String, Decodable {
        case sabah = "أذكار الصباح"
        case masaa = "أذكار المساء"
    }
}

extension Zekr {
    func toDAO(_ dayId: Int64) -> ANAzkarTimedDAO {
        .init(
            name: zekr,
            reward: purpose,
            time: category.toDAO(),
            repetation: count,
            dayId: dayId)
    }
}

extension Zekr.Category {
    func toDAO() -> ANAzkarTimedDAO.Time {
        switch self {
        case .sabah:
            return .day
        case .masaa:
            return .night
        }
    }
}

// MARK: - FailableDecodable

struct FailableDecodable<Base: Decodable>: Decodable {
    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        base = try? container.decode(Base.self)
    }
}

// MARK: - FailableCodableArray

struct FailableCodableArray<Element: Codable>: Codable {
    var elements: [Element]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var elements = [Element]()
        if let count = container.count {
            elements.reserveCapacity(count)
        }

        while !container.isAtEnd {
            if
                let element = try container
                    .decode(FailableDecodable<Element>.self).base {
                elements.append(element)
            }
        }

        self.elements = elements
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }
}
