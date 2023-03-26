//
//  SwiftUIView 2.swift
//
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import SwiftUI

// MARK: - StatProgress

struct StatProgress: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let stat: String
}

// MARK: - StatCard

struct StatCard: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - SwiftUIView_2_Previews

struct SwiftUIView_2_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(store: .mock)
    }
}
