//
//  SwiftUIView.swift
//
//
//  Created by Ahmed Ramy on 04/04/2023.
//

import SwiftUI


// MARK: - SwiftUIView

struct SwiftUIView: View {
    var body: some View {
        ZStack {
            Color.mono.ash.ignoresSafeArea()
        }
    }
}

// MARK: - SwiftUIView_Previews

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
