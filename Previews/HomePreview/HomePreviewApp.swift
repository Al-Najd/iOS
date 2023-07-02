//
//  HomePreviewApp.swift
//  HomePreview
//
//  Created by Ahmed Ramy on 04/04/2023.
//

import SwiftUI


@main
struct HomePreviewApp: App {
    let plugins: [AppPlugin] = [
        ThemePlugin(),
        CorePlugin(),
        AppearancesPlugin(),
        ReportPlugin(),
    ]

    var body: some Scene {
        WindowGroup {
            HomeView(store: .init(initialState: .init(), reducer: Home()))
                .onAppear {
                    plugins.forEach { $0.setup() }
                }
        }
    }
}
