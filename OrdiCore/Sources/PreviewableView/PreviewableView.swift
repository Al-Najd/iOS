//
//  PreviewableView.swift
//  Trojan
//
//  Created by Ahmed Ramy on 17/01/2022.
//

import SwiftUI

public typealias PreviewableView<T: View> = WrapperView<T>

@frozen
public enum PreviewableFeatures: Identifiable {
  case darkMode
  case localization([LocalizationVariation])
  case smallDevice
  case noNotch
  case iPad
  
  public var id: String {
    switch self {
    case .darkMode:
      return "darkMode"
    case .localization:
      return "localization"
    case .smallDevice:
      return "smallDevice"
    case .noNotch:
      return "noNotch"
    case .iPad:
      return "iPad"
    }
  }
}

public struct LocalizationVariation: Identifiable, Equatable, Hashable {
    public var id: String { "\(locale)-\(includeDarkMode)" }
    let locale: String
    let includeDarkMode: Bool
    
    public init(locale: String, includeDarkMode: Bool) {
        self.locale = locale
        self.includeDarkMode = includeDarkMode
    }
}

public extension Array where Element == PreviewableFeatures {
  static let all: [PreviewableFeatures] = [
    .darkMode,
    .localization(Bundle.main.localizations.map {
        return LocalizationVariation(locale: $0, includeDarkMode: true)
      }
    ),
    .smallDevice,
    .noNotch,
    .iPad,
    .darkMode,
  ]
}

public struct WrapperView<Content: View>: View {
  private let injectedView: () -> Content
  private let features: [PreviewableFeatures]
  
  public init(_ features: [PreviewableFeatures] = .all, @ViewBuilder injectedView: @escaping () -> Content) {
    self.injectedView = injectedView
    self.features = features
  }
  
  public var body: some View {
    Group {
      generateView(features: features)
    }
  }
  
  @ViewBuilder
  func generateView(features: [PreviewableFeatures]) -> some View {
    ForEach(features) { feature in
      switch feature {
      case .darkMode:
        Group {
          injectedView()
          injectedView()
            .preferredColorScheme(.dark)
        }
      case .localization(let variations):
          ForEach(variations) { variation in
              injectedView()
                  .environment(\.locale, Locale(identifier: variation.locale))
              if variation.includeDarkMode {
                  injectedView()
                      .environment(\.locale, Locale(identifier: variation.locale))
                      .preferredColorScheme(.dark)
              }
          }
      case .smallDevice:
        Group {
          injectedView()
            .previewDevice("iPod touch (7th generation)")
        }
      case .noNotch:
        injectedView()
          .previewDevice("iPhone 8")
      case .iPad:
        injectedView()
          .previewDevice("iPad Pro (12.9-inch) (5th generation)")
      }
    }
  }
}
