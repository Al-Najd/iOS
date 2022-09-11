//  swiftlint:disable all
//
//  The code generated using FigmaExport — Command line utility to export
//  colors, typography, icons and images from Figma to Xcode project.
//
//  https://github.com/RedMadRobot/figma-export
//
//  Don’t edit this code manually to avoid runtime crashes
//

import SwiftUI

private class BundleProvider {
    static let bundle = Bundle._module
}

public extension Color {
    static var appleDark: Color { Color("Apple / Dark", bundle: BundleProvider.bundle) }
    static var appleLight: Color { Color("Apple / Light", bundle: BundleProvider.bundle) }
    static var appleMedium: Color { Color("Apple / Medium", bundle: BundleProvider.bundle) }
    static var applePrimary: Color { Color("Apple / Primary", bundle: BundleProvider.bundle) }
    static var appleSuperlight: Color { Color("Apple / Superlight", bundle: BundleProvider.bundle) }
    static var blueberryDark: Color { Color("Blueberry / Dark", bundle: BundleProvider.bundle) }
    static var blueberryLight: Color { Color("Blueberry / Light", bundle: BundleProvider.bundle) }
    static var blueberryMedium: Color { Color("Blueberry / Medium", bundle: BundleProvider.bundle) }
    public static var blueberrySuperlight: Color { Color("Blueberry / Superlight", bundle: BundleProvider.bundle) }
    static var blueberryPrimary: Color { Color("Blueberry/Primary", bundle: BundleProvider.bundle) }
    static var cherryDark: Color { Color("Cherry / Dark", bundle: BundleProvider.bundle) }
    static var cherryLight: Color { Color("Cherry / Light", bundle: BundleProvider.bundle) }
    static var cherryMedium: Color { Color("Cherry / Medium", bundle: BundleProvider.bundle) }
    static var cherryPrimary: Color { Color("Cherry / Primary", bundle: BundleProvider.bundle) }
    static var cherrySuperlight: Color { Color("Cherry / Superlight", bundle: BundleProvider.bundle) }
    static var greysGunMetal: Color { Color("Greys / Gun Metal", bundle: BundleProvider.bundle) }
    static var greysNardo: Color { Color("Greys / Nardo", bundle: BundleProvider.bundle) }
    static var greysSpaceGrey: Color { Color("Greys / Space Grey", bundle: BundleProvider.bundle) }
    static var greysSuperLight: Color { Color("Greys / Super Light", bundle: BundleProvider.bundle) }
    static var greysWhite: Color { Color("Greys / White", bundle: BundleProvider.bundle) }
    static var greysBlackberry: Color { Color("Greys/Blackberry", bundle: BundleProvider.bundle) }
    static var primaryBlackberry: Color { Color("Primary/Blackberry", bundle: BundleProvider.bundle) }
    static var primaryBluberry: Color { Color("Primary/Bluberry", bundle: BundleProvider.bundle) }
    static var primaryNardoGrey: Color { Color("Primary/Nardo Grey", bundle: BundleProvider.bundle) }
    static var primarySolarbeam: Color { Color("Primary/Solarbeam", bundle: BundleProvider.bundle) }
    static var primarySpaceGrey: Color { Color("Primary/Space Grey", bundle: BundleProvider.bundle) }
    static var tangerineDark: Color { Color("Tangerine / Dark", bundle: BundleProvider.bundle) }
    static var tangerineLight: Color { Color("Tangerine / Light", bundle: BundleProvider.bundle) }
    static var tangerineMedium: Color { Color("Tangerine / Medium", bundle: BundleProvider.bundle) }
    static var tangerinePrimary: Color { Color("Tangerine / Primary", bundle: BundleProvider.bundle) }
    static var tangerineSuperlight: Color { Color("Tangerine / Superlight", bundle: BundleProvider.bundle) }
}

public extension Optional where Wrapped == Color {
    static var appleDark: Color { Color("Apple / Dark", bundle: BundleProvider.bundle) }
    static var appleLight: Color { Color("Apple / Light", bundle: BundleProvider.bundle) }
    static var appleMedium: Color { Color("Apple / Medium", bundle: BundleProvider.bundle) }
    static var applePrimary: Color { Color("Apple / Primary", bundle: BundleProvider.bundle) }
    static var appleSuperlight: Color { Color("Apple / Superlight", bundle: BundleProvider.bundle) }
    static var blueberryDark: Color { Color("Blueberry / Dark", bundle: BundleProvider.bundle) }
    static var blueberryLight: Color { Color("Blueberry / Light", bundle: BundleProvider.bundle) }
    static var blueberryMedium: Color { Color("Blueberry / Medium", bundle: BundleProvider.bundle) }
    public static var blueberrySuperlight: Color { Color("Blueberry / Superlight", bundle: BundleProvider.bundle) }
    static var blueberryPrimary: Color { Color("Blueberry/Primary", bundle: BundleProvider.bundle) }
    static var cherryDark: Color { Color("Cherry / Dark", bundle: BundleProvider.bundle) }
    static var cherryLight: Color { Color("Cherry / Light", bundle: BundleProvider.bundle) }
    static var cherryMedium: Color { Color("Cherry / Medium", bundle: BundleProvider.bundle) }
    static var cherryPrimary: Color { Color("Cherry / Primary", bundle: BundleProvider.bundle) }
    static var cherrySuperlight: Color { Color("Cherry / Superlight", bundle: BundleProvider.bundle) }
    static var greysGunMetal: Color { Color("Greys / Gun Metal", bundle: BundleProvider.bundle) }
    static var greysNardo: Color { Color("Greys / Nardo", bundle: BundleProvider.bundle) }
    static var greysSpaceGrey: Color { Color("Greys / Space Grey", bundle: BundleProvider.bundle) }
    static var greysSuperLight: Color { Color("Greys / Super Light", bundle: BundleProvider.bundle) }
    static var greysWhite: Color { Color("Greys / White", bundle: BundleProvider.bundle) }
    static var greysBlackberry: Color { Color("Greys/Blackberry", bundle: BundleProvider.bundle) }
    static var primaryBlackberry: Color { Color("Primary/Blackberry", bundle: BundleProvider.bundle) }
    static var primaryBluberry: Color { Color("Primary/Bluberry", bundle: BundleProvider.bundle) }
    static var primaryNardoGrey: Color { Color("Primary/Nardo Grey", bundle: BundleProvider.bundle) }
    static var primarySolarbeam: Color { Color("Primary/Solarbeam", bundle: BundleProvider.bundle) }
    static var primarySpaceGrey: Color { Color("Primary/Space Grey", bundle: BundleProvider.bundle) }
    static var tangerineDark: Color { Color("Tangerine / Dark", bundle: BundleProvider.bundle) }
    static var tangerineLight: Color { Color("Tangerine / Light", bundle: BundleProvider.bundle) }
    static var tangerineMedium: Color { Color("Tangerine / Medium", bundle: BundleProvider.bundle) }
    static var tangerinePrimary: Color { Color("Tangerine / Primary", bundle: BundleProvider.bundle) }
    static var tangerineSuperlight: Color { Color("Tangerine / Superlight", bundle: BundleProvider.bundle) }
}

private extension Foundation.Bundle {
    private class BundleFinder {}

    /// Returns the resource bundle associated with the current Swift module.
    static var _module: Bundle = {
        let bundleNames = ["AlNajd_Assets"]

        let candidates: [URL?] = {
            var candidates = [
                // Bundle should be present here when the package is linked into an App.
                Bundle.main.resourceURL,
                // Bundle should be present here when the package is linked into a framework.
                Bundle(for: BundleFinder.self).resourceURL,
                // For command-line tools.
                Bundle.main.bundleURL,
            ]
#if DEBUG
            candidates.append(contentsOf: [
                // Bundle should be present here when the package is used in UI Tests.
                Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent(),
                // Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/").
                Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
                Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
            ])
#endif
            return candidates
        }()

        for candidate in candidates {
            for bundleName in bundleNames {
                let bundlePathiOS = candidate?.appendingPathComponent(bundleName + ".bundle")
                if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                    return bundle
                }
            }
        }
        fatalError("unable to find bundle named \(bundleNames)")
    }()
}
