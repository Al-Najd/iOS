//
//  File.swift
//
//
//  Created by Ahmed Ramy on 31/03/2023.
//

import SwiftUI

public extension View {
    func embedInHost() -> UIViewController {
        UIHostingController(rootView: self)
    }
}
