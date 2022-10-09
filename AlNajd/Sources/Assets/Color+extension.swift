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
    static let appleDark: Color = Color("Apple / Dark", bundle: BundleProvider.bundle)
    static let appleLight: Color = Color("Apple / Light", bundle: BundleProvider.bundle)
    static let appleMedium: Color = Color("Apple / Medium", bundle: BundleProvider.bundle)
    static let applePrimary: Color = Color("Apple / Primary", bundle: BundleProvider.bundle)
    static let appleSuperlight: Color = Color("Apple / Superlight", bundle: BundleProvider.bundle)
    static let blueberryDark: Color = Color("Blueberry / Dark", bundle: BundleProvider.bundle)
    static let blueberryLight: Color = Color("Blueberry / Light", bundle: BundleProvider.bundle)
    static let blueberryMedium: Color = Color("Blueberry / Medium", bundle: BundleProvider.bundle)
    static let blueberrySuperlight: Color = Color("Blueberry / Superlight", bundle: BundleProvider.bundle)
    static let blueberryPrimary: Color = Color("Blueberry/Primary", bundle: BundleProvider.bundle)
    static let cherryDark: Color = Color("Cherry / Dark", bundle: BundleProvider.bundle)
    static let cherryLight: Color = Color("Cherry / Light", bundle: BundleProvider.bundle)
    static let cherryMedium: Color = Color("Cherry / Medium", bundle: BundleProvider.bundle)
    static let cherryPrimary: Color = Color("Cherry / Primary", bundle: BundleProvider.bundle)
    static let cherrySuperlight: Color = Color("Cherry / Superlight", bundle: BundleProvider.bundle)
    static let greysGunMetal: Color = Color("Greys / Gun Metal", bundle: BundleProvider.bundle)
    static let greysNardo: Color = Color("Greys / Nardo", bundle: BundleProvider.bundle)
    static let greysSpaceGrey: Color = Color("Greys / Space Grey", bundle: BundleProvider.bundle)
    static let greysSuperLight: Color = Color("Greys / Super Light", bundle: BundleProvider.bundle)
    static let greysWhite: Color = Color("Greys / White", bundle: BundleProvider.bundle)
    static let greysBlackberry: Color = Color("Greys/Blackberry", bundle: BundleProvider.bundle)
    static let primaryBlackberry: Color = Color("Primary/Blackberry", bundle: BundleProvider.bundle)
    static let primaryBluberry: Color = Color("Primary/Bluberry", bundle: BundleProvider.bundle)
    static let primaryNardoGrey: Color = Color("Primary/Nardo Grey", bundle: BundleProvider.bundle)
    static let primarySolarbeam: Color = Color("Primary/Solarbeam", bundle: BundleProvider.bundle)
    static let primarySpaceGrey: Color = Color("Primary/Space Grey", bundle: BundleProvider.bundle)
    static let tangerineDark: Color = Color("Tangerine / Dark", bundle: BundleProvider.bundle)
    static let tangerineLight: Color = Color("Tangerine / Light", bundle: BundleProvider.bundle)
    static let tangerineMedium: Color = Color("Tangerine / Medium", bundle: BundleProvider.bundle)
    static let tangerinePrimary: Color = Color("Tangerine / Primary", bundle: BundleProvider.bundle)
    static let tangerineSuperlight: Color = Color("Tangerine / Superlight", bundle: BundleProvider.bundle)
	static let shadowMedium = Color("Shadow / Medium", bundle: BundleProvider.bundle)
	static let shadowBlueperry = Color("Shadow /Bluberry", bundle: BundleProvider.bundle)
	static let shadowCherry = Color("Shadow /Cherry", bundle: BundleProvider.bundle)
	static let shadowTangerine = Color("Shadow /Tangerine", bundle: BundleProvider.bundle)
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
