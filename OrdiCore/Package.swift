// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "OrdiCore",
  platforms: [
    .iOS(.v15),
    .macOS(.v11)
  ],
  products: [
    .library(name: "Core", targets: ["Core"]),
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
    .library(name: "ReusableUI", targets: ["ReusableUI"]),
    .library(name: "Utils", targets: ["Utils"]),
    .library(name: "Business", targets: ["Business"]),
    .library(name: "OrdiLogging", targets: ["OrdiLogging"]),
    .library(name: "Entity", targets: ["Entity"]),
    .library(name: "PreviewableView", targets: ["PreviewableView"]),
    .library(name: "Animations", targets: ["Animations"])
  ],
  dependencies: [
    .package(
      name: "FontBlaster",
      url: "https://github.com/ArtSabintsev/FontBlaster.git",
      .upToNextMinor(from: .init(5, 2, 0))
    ),
    .package(
      name: "Alamofire",
      url: "https://github.com/Alamofire/Alamofire.git",
      .upToNextMinor(from: .init(5, 5, 0))
    ),
    .package(
        name: "Pulse",
        url: "https://github.com/kean/Pulse.git",
        .upToNextMinor(from: .init(0, 20, 1))
    ),
    .package(
        name: "Sentry",
        url: "https://github.com/getsentry/sentry-cocoa.git",
        .upToNextMinor(from: .init(7, 9, 0))
    ),
    .package(
        name: "KeychainSwift",
        url: "https://github.com/evgenyneu/keychain-swift",
        .upToNextMajor(from: .init(20, 0, 0))
    ),
    .package(
        name: "Lottie",
        url: "https://github.com/airbnb/lottie-ios",
        .upToNextMajor(from: .init(3, 3, 0))
    )
  ],
  targets: [
    .target(
      name: "Core",
      dependencies: [
        "DesignSystem",
        "ReusableUI",
        "Utils",
        "Business",
        "OrdiLogging",
        "PreviewableView",
        "Animations"
      ]
    ),
    .target(
        name: "OrdiLogging",
        dependencies: [
            "Entity",
            .product(name: "Pulse", package: "Pulse"),
            .product(name: "Sentry", package: "Sentry")
        ]
    ),
    .target(
        name: "Entity"
    ),
    .target(
      name: "DesignSystem",
      dependencies: [
        "OrdiLogging",
        "Utils",
        .product(name: "FontBlaster", package: "FontBlaster")
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
        name: "Utils",
        dependencies: [
            "OrdiLogging"
        ]
    ),
    .target(
      name: "ReusableUI",
      dependencies: [
        "Utils",
        "DesignSystem"
      ]
    ),
    .target(
        name: "Business",
        dependencies: [
            "Entity",
            "OrdiLogging",
            "Utils",
            .product(name: "Alamofire", package: "Alamofire"),
            .product(name: "KeychainSwift", package: "KeychainSwift")
        ]
    ),
    .target(name: "PreviewableView"),
    .target(
        name: "Animations",
        dependencies: [
            .product(name: "Lottie", package: "Lottie")
        ]
    )
  ]
)
