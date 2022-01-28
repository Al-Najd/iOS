//
//  Zekr.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 04/01/2022.
//

import Foundation

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
    self.category = try values.decode(Category.self, forKey: .category)
    self.count = Int(try values.decode(String.self, forKey: .count)) ?? 0
    self.purpose = try values.decode(String.self, forKey: .purpose)
    self.reference = try values.decode(String.self, forKey: .reference)
    self.zekr = try values.decode(String.self, forKey: .zekr)
  }
  
  func encode(to encoder: Encoder) throws {
    fatalError()
  }
  
  static var mainAzkar: [Zekr] = {
    let decoder = JSONDecoder()
    guard
         let url = Bundle.main.url(forResource: "azkar-db", withExtension: "json"),
         let data = try? Data(contentsOf: url),
         let azkar = try? decoder
          .decode(FailableCodableArray<Zekr>.self, from: data)
          .elements
    else {
         return []
    }

    return azkar
  }()
}

extension Zekr {
  enum Category: String, Decodable {
    case sabah = "أذكار الصباح"
    case masaa = "أذكار المساء"
  }
}

extension Zekr.Category {
  func toAzkarCategory() -> AzkarCategory {
    switch self {
    case .sabah:
      return .sabah
    case .masaa:
      return .masaa
    }
  }
}

struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

struct FailableCodableArray<Element : Codable> : Codable {

    var elements: [Element]

    init(from decoder: Decoder) throws {

        var container = try decoder.unkeyedContainer()

        var elements = [Element]()
        if let count = container.count {
            elements.reserveCapacity(count)
        }

        while !container.isAtEnd {
            if let element = try container
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
