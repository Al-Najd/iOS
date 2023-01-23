//
//  ContentView.swift
//  iOS
//
//  Created by ahmed on 23/01/2023.
//  Copyright © 2023 com.nerdor. All rights reserved.
//

import Reminders
import SwiftUI

// MARK: - ContentView

public struct ContentView: View {
    public init() { }

    public var body: some View {
        RemindersView()
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
