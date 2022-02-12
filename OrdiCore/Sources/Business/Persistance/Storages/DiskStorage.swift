//
//  DiskStorage.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation
import Entity
import Utils

public final class DiskStorage {
  private let queue: DispatchQueue
  private let fileManager: FileManager
  private let path: URL
  
  public init(
    queue: DispatchQueue = .global(qos: DispatchQoS.QoSClass.default),
    fileManager: FileManager = .default,
    path: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]) {
    self.queue = queue
    self.fileManager = fileManager
    self.path = path
  }
}

extension DiskStorage: WritableStorage {
  public func remove<T>(type: T.Type, for key: StorageKey) throws where T : Codable {
    do {
      try fileManager.removeItem(atPath: path.appendingPathComponent(key.key).absoluteString)
    } catch {
      throw StorageError.cantDelete(key)
    }
  }
  
  public func save<T: Codable>(value: T, for key: StorageKey) throws {
    let url = path.appendingPathComponent(key.key)
    do {
      try self.createFolders(in: url)
      try value.encode().write(to: url, options: .atomic)
    } catch {
      throw StorageError.cantWrite(error)
    }
  }
}

extension DiskStorage {
  private func createFolders(in url: URL) throws {
    let folderUrl = url.deletingLastPathComponent()
    if !fileManager.fileExists(atPath: folderUrl.path) {
      try fileManager.createDirectory(
        at: folderUrl,
        withIntermediateDirectories: true,
        attributes: nil
      )
    }
  }
}

extension DiskStorage: ReadableStorage {
  public func fetchValue<T: Codable>(for key: StorageKey) -> T? {
    let url = path.appendingPathComponent(key.key)
    guard let data = fileManager.contents(atPath: url.path) else {
      return nil
    }
    
    guard let value = data.decode(T.self) else {
      return nil
    }
    
    return value
  }
}
