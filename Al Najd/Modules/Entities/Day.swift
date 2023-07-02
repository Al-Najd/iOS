//
//  Day.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 02/07/2023.
//

import Foundation
import ComposableArchitecture

public struct Day: Identifiable, Equatable {
    public let id: Int
    let date: Date
    let prayers: IdentifiedArrayOf<Prayer>

    let morningAzkar: IdentifiedArrayOf<Zekr>
    let nightAzkar: IdentifiedArrayOf<Zekr>
}
