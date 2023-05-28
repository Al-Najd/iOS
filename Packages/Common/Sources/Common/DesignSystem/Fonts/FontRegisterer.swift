//
//  File.swift
//
//
//  Created by Ahmed Ramy on 05/04/2023.
//

import CoreText
import Foundation
import Loggers
import UIKit

// MARK: - FontRegisterer

public enum FontRegisterer {
    public static func register() {
        getFontURLs().forEach { UIFont.register(from: $0) }
    }

    private static func getFontURLs() -> [URL] {
        let bundle = Bundle.module
        let filenames = [
            "Poppins-Bold",
            "Poppins-Regular"
        ]
        return filenames.map { bundle.url(forResource: $0, withExtension: "ttf")! }
    }
}

extension UIFont {
    static func register(from url: URL) {
        guard let fontDataProvider = CGDataProvider(url: url as CFURL) else {
            Log.error("Could not get reference to Font's DataProvider")
            return
        }
        guard let font = CGFont(fontDataProvider) else {
            Log.error("Could not get Font from CoreGraphics")
            return
        }
        var error: Unmanaged<CFError>?
        guard CTFontManagerRegisterGraphicsFont(font, &error) else {
            Log.error("Error registering font: \(error.debugDescription)")
            return
        }
    }
}
