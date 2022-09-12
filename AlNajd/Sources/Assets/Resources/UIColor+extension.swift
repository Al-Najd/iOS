//  swiftlint:disable all
//
//  The code generated using FigmaExport — Command line utility to export
//  colors, typography, icons and images from Figma to Xcode project.
//
//  https://github.com/RedMadRobot/figma-export
//
//  Don’t edit this code manually to avoid runtime crashes
//

import UIKit

private class BundleProvider {
    static let bundle = Bundle._module
}

public extension UIColor {
    static var appleDark: UIColor { UIColor(named: "Apple / Dark", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var appleLight: UIColor { UIColor(named: "Apple / Light", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var appleMedium: UIColor { UIColor(named: "Apple / Medium", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var applePrimary: UIColor { UIColor(named: "Apple / Primary", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var appleSuperlight: UIColor { UIColor(named: "Apple / Superlight", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var blueberryDark: UIColor { UIColor(named: "Blueberry / Dark", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var blueberryLight: UIColor { UIColor(named: "Blueberry / Light", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var blueberryMedium: UIColor { UIColor(named: "Blueberry / Medium", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var blueberrySuperlight: UIColor { UIColor(named: "Blueberry / Superlight", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var blueberryPrimary: UIColor { UIColor(named: "Blueberry/Primary", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var cherryDark: UIColor { UIColor(named: "Cherry / Dark", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var cherryLight: UIColor { UIColor(named: "Cherry / Light", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var cherryMedium: UIColor { UIColor(named: "Cherry / Medium", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var cherryPrimary: UIColor { UIColor(named: "Cherry / Primary", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var cherrySuperlight: UIColor { UIColor(named: "Cherry / Superlight", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var greysGunMetal: UIColor { UIColor(named: "Greys / Gun Metal", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var greysNardo: UIColor { UIColor(named: "Greys / Nardo", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var greysSpaceGrey: UIColor { UIColor(named: "Greys / Space Grey", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var greysSuperLight: UIColor { UIColor(named: "Greys / Super Light", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var greysWhite: UIColor { UIColor(named: "Greys / White", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var greysBlackberry: UIColor { UIColor(named: "Greys/Blackberry", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var primaryBlackberry: UIColor { UIColor(named: "Primary/Blackberry", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var primaryBluberry: UIColor { UIColor(named: "Primary/Bluberry", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var primaryNardoGrey: UIColor { UIColor(named: "Primary/Nardo Grey", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var primarySolarbeam: UIColor { UIColor(named: "Primary/Solarbeam", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var primarySpaceGrey: UIColor { UIColor(named: "Primary/Space Grey", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var tangerineDark: UIColor { UIColor(named: "Tangerine / Dark", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var tangerineLight: UIColor { UIColor(named: "Tangerine / Light", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var tangerineMedium: UIColor { UIColor(named: "Tangerine / Medium", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var tangerinePrimary: UIColor { UIColor(named: "Tangerine / Primary", in: BundleProvider.bundle, compatibleWith: nil)! }
    static var tangerineSuperlight: UIColor { UIColor(named: "Tangerine / Superlight", in: BundleProvider.bundle, compatibleWith: nil)! }
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
