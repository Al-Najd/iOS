//
//  StorageError.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 11/16/20.
//  Copyright © 2020 Ahmed Ramy. All rights reserved.
//

import Foundation

public enum StorageError: Error {
  case notFound
  case cantWrite(Error)
  case cantDelete(StorageKey)
}
