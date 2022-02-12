//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 12/02/2022.
//

import Foundation

public extension String {
  /// SwifterSwift: Returns a localized string, with an optional comment for translators.
  ///
  ///        "Hello world".localized -> Hallo Welt
  ///
  var localized: String {
      return NSLocalizedString(self, tableName: "Localizables", bundle: .module, comment: "")
  }
  
  func localized(arguments: CVarArg...) -> String {
      return String(format: self.localized, arguments: arguments.map { "\($0)" })
  }
}

class CurrentBundleFinder {}

extension Foundation.Bundle {
        
    static var localizationBundle: Bundle = {
        /* The name of your local package, prepended by "LocalPackages_" */
        let bundleName = "AlNajd_Localization"
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            /* For command-line tools. */
            Bundle.main.bundleURL,
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
            Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named \(bundleName)")
    }()
}
