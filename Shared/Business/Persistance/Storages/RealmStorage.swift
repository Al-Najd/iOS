//
//  RealmStorage.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 24/04/2021.
//

//import Unrealm
//import RealmSwift
//
//final class RealmStorage {
//  private var realm = try! RealmSwift.Realm()
//}
//
//extension RealmStorage: WritableStorage {
//  func save<T: Cachable>(value: T, for key: StorageKey) throws {
//    try realm.write {
//      self.realm.add(value, update: .all)
//    }
//  }
//
//  func remove<T: Cachable>(type: T.Type, for key: StorageKey) throws {
//    guard let objectToRemove = realm.object(ofType: type, forPrimaryKey: type.primaryKey()) else {
//      LoggersManager.error("Trying to delete something that is not there")
//      return
//    }
//
//    realm.delete(objectToRemove)
//  }
//}
//
//extension RealmStorage: ReadableStorage {
//  func fetchValue<T: Cachable>(for key: StorageKey) throws -> T {
//
//    guard let object = realm.object(ofType: T.self, forPrimaryKey: "1") else {
//      LoggersManager.error("Trying to find the object for this \(key)".tagWith(.realm))
//      throw "Couldn't Find Object for \(key)".asError
//    }
//
//    return object
//  }
//}
