// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum UDesignSystemAsset {
  public enum Colors {
    public static let aliasErrorBackground = UDesignSystemColors(name: "aliasErrorBackground")
    public static let aliasErrorBackgroundStrong = UDesignSystemColors(name: "aliasErrorBackgroundStrong")
    public static let aliasErrorDefault = UDesignSystemColors(name: "aliasErrorDefault")
    public static let aliasErrorDefaultStrong = UDesignSystemColors(name: "aliasErrorDefaultStrong")
    public static let aliasErrorDefaultWeak = UDesignSystemColors(name: "aliasErrorDefaultWeak")
    public static let aliasGrayscaleBackground = UDesignSystemColors(name: "aliasGrayscaleBackground")
    public static let aliasGrayscaleBackgroundWeak = UDesignSystemColors(name: "aliasGrayscaleBackgroundWeak")
    public static let aliasGrayscaleBody = UDesignSystemColors(name: "aliasGrayscaleBody")
    public static let aliasGrayscaleHeader = UDesignSystemColors(name: "aliasGrayscaleHeader")
    public static let aliasGrayscaleHeaderWeak = UDesignSystemColors(name: "aliasGrayscaleHeaderWeak")
    public static let aliasGrayscaleInput = UDesignSystemColors(name: "aliasGrayscaleInput")
    public static let aliasGrayscaleLabel = UDesignSystemColors(name: "aliasGrayscaleLabel")
    public static let aliasGrayscaleLine = UDesignSystemColors(name: "aliasGrayscaleLine")
    public static let aliasGrayscalePlaceholder = UDesignSystemColors(name: "aliasGrayscalePlaceholder")
    public static let aliasPrimaryBackground = UDesignSystemColors(name: "aliasPrimaryBackground")
    public static let aliasPrimaryBackgroundStrong = UDesignSystemColors(name: "aliasPrimaryBackgroundStrong")
    public static let aliasPrimaryDefault = UDesignSystemColors(name: "aliasPrimaryDefault")
    public static let aliasPrimaryDefaultStrong = UDesignSystemColors(name: "aliasPrimaryDefaultStrong")
    public static let aliasPrimaryDefaultWeak = UDesignSystemColors(name: "aliasPrimaryDefaultWeak")
    public static let aliasSecondaryBackground = UDesignSystemColors(name: "aliasSecondaryBackground")
    public static let aliasSecondaryBackgroundStrong = UDesignSystemColors(name: "aliasSecondaryBackgroundStrong")
    public static let aliasSecondaryDark = UDesignSystemColors(name: "aliasSecondaryDark")
    public static let aliasSecondaryDefault = UDesignSystemColors(name: "aliasSecondaryDefault")
    public static let aliasSecondaryDefaultWeak = UDesignSystemColors(name: "aliasSecondaryDefaultWeak")
    public static let aliasSuccessBackground = UDesignSystemColors(name: "aliasSuccessBackground")
    public static let aliasSuccessBackgroundStrong = UDesignSystemColors(name: "aliasSuccessBackgroundStrong")
    public static let aliasSuccessDefault = UDesignSystemColors(name: "aliasSuccessDefault")
    public static let aliasSuccessDefaultStrong = UDesignSystemColors(name: "aliasSuccessDefaultStrong")
    public static let aliasSuccessDefaultWeak = UDesignSystemColors(name: "aliasSuccessDefaultWeak")
    public static let aliasWarningBackground = UDesignSystemColors(name: "aliasWarningBackground")
    public static let aliasWarningBackgroundStrong = UDesignSystemColors(name: "aliasWarningBackgroundStrong")
    public static let aliasWarningDefault = UDesignSystemColors(name: "aliasWarningDefault")
    public static let aliasWarningDefaultStrong = UDesignSystemColors(name: "aliasWarningDefaultStrong")
    public static let aliasWarningDefaultWeak = UDesignSystemColors(name: "aliasWarningDefaultWeak")
  }
  public enum Icons {
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class UDesignSystemColors {
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

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension UDesignSystemColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: UDesignSystemColors) {
    let bundle = UDesignSystemResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
