//
//  RemindersApp.swift
//  Reminders
//
//  Created by ahmed on 23/01/2023.
//  Copyright © 2023 com.nerdor. All rights reserved.
//

import ComposableArchitecture
import Reminders
import SwiftUI

@main
struct RemindersApp: App {
    var body: some Scene {
        WindowGroup {
            RemindersView(
                store: .init(
                    initialState: .init(),
                    reducer: Reminders()))
        }
    }
}
