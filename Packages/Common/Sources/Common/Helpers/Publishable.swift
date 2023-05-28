//
//  Publishable.swift
//  CAFU
//
//  Created by Ahmed Ramy on 13/10/2022.
//

import Foundation

final class Publishable<T> {
    @Published var value: T

    init(value: T) {
        self.value = value
    }
}
