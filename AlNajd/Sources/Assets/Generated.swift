// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#elseif os(tvOS) || os(watchOS)
    import UIKit
#endif
#if canImport(SwiftUI)
    import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
    public enum Colors {
        public enum Apple {
            public static let dark = ColorAsset(name: "Apple / Dark")
            public static let light = ColorAsset(name: "Apple / Light")
            public static let medium = ColorAsset(name: "Apple / Medium")
            public static let primary = ColorAsset(name: "Apple / Primary")
            public static let superlight = ColorAsset(name: "Apple / Superlight")
        }

        public enum Blueberry {
            public static let dark = ColorAsset(name: "Blueberry / Dark")
            public static let light = ColorAsset(name: "Blueberry / Light")
            public static let medium = ColorAsset(name: "Blueberry / Medium")
            public static let superlight = ColorAsset(name: "Blueberry / Superlight")
            public static let primary = ColorAsset(name: "Blueberry /Primary")
        }

        public enum Cherry {
            public static let dark = ColorAsset(name: "Cherry / Dark")
            public static let light = ColorAsset(name: "Cherry / Light")
            public static let medium = ColorAsset(name: "Cherry / Medium")
            public static let primary = ColorAsset(name: "Cherry / Primary")
            public static let superlight = ColorAsset(name: "Cherry / Superlight")
        }

        public enum Gradients {
            public enum Home {
                public enum HighCharge {
                    public static let progressEnd = ColorAsset(name: "Gradients/Home/HighCharge/ProgressEnd")
                    public static let progressStart = ColorAsset(name: "Gradients/Home/HighCharge/ProgressStart")
                }

                public enum LowCharge {
                    public static let progressEnd = ColorAsset(name: "Gradients/Home/LowCharge/ProgressEnd")
                    public static let progressStart = ColorAsset(name: "Gradients/Home/LowCharge/ProgressStart")
                }

                public enum MidCharge {
                    public static let progressEnd = ColorAsset(name: "Gradients/Home/MidCharge/ProgressEnd")
                    public static let progressStart = ColorAsset(name: "Gradients/Home/MidCharge/ProgressStart")
                }
            }
        }

        public enum Greys {
            public static let gunMetal = ColorAsset(name: "Greys / Gun Metal")
            public static let nardo = ColorAsset(name: "Greys / Nardo")
            public static let spaceGrey = ColorAsset(name: "Greys / Space Grey")
            public static let superLight = ColorAsset(name: "Greys / Super Light")
            public static let white = ColorAsset(name: "Greys / White")
            public static let blackberry = ColorAsset(name: "Greys /Blackberry")
        }

        public enum Primary {
            public static let blackberry = ColorAsset(name: "Primary/Blackberry")
            public static let bluberry = ColorAsset(name: "Primary/Bluberry")
            public static let nardoGrey = ColorAsset(name: "Primary/Nardo Grey")
            public static let solarbeam = ColorAsset(name: "Primary/Solarbeam")
            public static let spaceGrey = ColorAsset(name: "Primary/Space Grey")
        }

        public enum Shadow {
            public static let medium = ColorAsset(name: "Shadow / Medium")
            public static let bluberry = ColorAsset(name: "Shadow /Bluberry")
            public static let cherry = ColorAsset(name: "Shadow /Cherry")
            public static let tangerine = ColorAsset(name: "Shadow /Tangerine")
        }

        public enum Tangerine {
            public static let dark = ColorAsset(name: "Tangerine / Dark")
            public static let light = ColorAsset(name: "Tangerine / Light")
            public static let medium = ColorAsset(name: "Tangerine / Medium")
            public static let primary = ColorAsset(name: "Tangerine / Primary")
            public static let superlight = ColorAsset(name: "Tangerine / Superlight")
        }
    }

    public enum Prayers {
        public enum Images {
            public static let asrImage = ImageAsset(name: "asrImage")
            public static let dhuhrImage = ImageAsset(name: "dhuhrImage")
            public static let duhaImage = ImageAsset(name: "duhaImage")
            public static let fajrImage = ImageAsset(name: "fajrImage")
            public static let ishaImage = ImageAsset(name: "ishaImage")
            public static let maghribImage = ImageAsset(name: "maghribImage")
        }
    }
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
    public fileprivate(set) var name: String

    #if os(macOS)
        public typealias Color = NSColor
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias Color = UIColor
    #endif

    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    public private(set) lazy var color: Color = {
        guard let color = Color(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()

    #if os(iOS) || os(tvOS)
        @available(iOS 11.0, tvOS 11.0, *)
        public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
            let bundle = BundleToken.bundle
            guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
                fatalError("Unable to load color asset named \(name).")
            }
            return color
        }
    #endif

    #if canImport(SwiftUI)
        @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
        public private(set) lazy var swiftUIColor: SwiftUI.Color = .init(asset: self)
    #endif

    fileprivate init(name: String) {
        self.name = name
    }
}

public extension ColorAsset.Color {
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    convenience init?(asset: ColorAsset) {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
            self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            self.init(named: NSColor.Name(asset.name), bundle: bundle)
        #elseif os(watchOS)
            self.init(named: asset.name)
        #endif
    }
}

#if canImport(SwiftUI)
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    public extension SwiftUI.Color {
        init(asset: ColorAsset) {
            let bundle = BundleToken.bundle
            self.init(asset.name, bundle: bundle)
        }
    }
#endif

public struct ImageAsset {
    public fileprivate(set) var name: String

    #if os(macOS)
        public typealias Image = NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias Image = UIImage
    #endif

    @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
    public var image: Image {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
            let image = Image(named: name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            let name = NSImage.Name(self.name)
            let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
        #elseif os(watchOS)
            let image = Image(named: name)
        #endif
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }

    #if os(iOS) || os(tvOS)
        @available(iOS 8.0, tvOS 9.0, *)
        public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
            let bundle = BundleToken.bundle
            guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
                fatalError("Unable to load image asset named \(name).")
            }
            return result
        }
    #endif

    #if canImport(SwiftUI)
        @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
        public var swiftUIImage: SwiftUI.Image {
            SwiftUI.Image(asset: self)
        }
    #endif
}

public extension ImageAsset.Image {
    @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
    @available(macOS, deprecated,
               message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
    convenience init?(asset: ImageAsset) {
        #if os(iOS) || os(tvOS)
            let bundle = BundleToken.bundle
            self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            self.init(named: NSImage.Name(asset.name))
        #elseif os(watchOS)
            self.init(named: asset.name)
        #endif
    }
}

#if canImport(SwiftUI)
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    public extension SwiftUI.Image {
        init(asset: ImageAsset) {
            let bundle = BundleToken.bundle
            self.init(asset.name, bundle: bundle)
        }

        init(asset: ImageAsset, label: Text) {
            let bundle = BundleToken.bundle
            self.init(asset.name, bundle: bundle, label: label)
        }

        init(decorative asset: ImageAsset) {
            let bundle = BundleToken.bundle
            self.init(decorative: asset.name, bundle: bundle)
        }
    }
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
