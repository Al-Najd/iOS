// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum UDesignSystemFontFamily {
  public enum Cairo {
    public static let bold = UDesignSystemFontConvertible(name: "Cairo-Bold", family: "Cairo", path: "Cairo-Bold.ttf")
    public static let regular = UDesignSystemFontConvertible(name: "Cairo-Regular", family: "Cairo", path: "Cairo-Regular.ttf")
    public static let all: [UDesignSystemFontConvertible] = [bold, regular]
  }
  public enum Poppins {
    public static let bold = UDesignSystemFontConvertible(name: "Poppins-Bold", family: "Poppins", path: "Poppins-Bold.ttf")
    public static let regular = UDesignSystemFontConvertible(name: "Poppins-Regular", family: "Poppins", path: "Poppins-Regular.ttf")
    public static let all: [UDesignSystemFontConvertible] = [bold, regular]
  }
  public enum SFProRounded {
    public static let bold = UDesignSystemFontConvertible(name: "SFProRounded-Bold", family: "SF Pro Rounded", path: "SFProRounded-Bold.otf")
    public static let regular = UDesignSystemFontConvertible(name: "SFProRounded-Regular", family: "SF Pro Rounded", path: "SFProRounded-Regular.otf")
    public static let all: [UDesignSystemFontConvertible] = [bold, regular]
  }
  public static let allCustomFonts: [UDesignSystemFontConvertible] = [Cairo.all, Poppins.all, SFProRounded.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct UDesignSystemFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension UDesignSystemFontConvertible.Font {
  convenience init?(font: UDesignSystemFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftlint:enable all
// swiftformat:enable all
