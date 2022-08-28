// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "AlNajd",
  defaultLocalization: "ar",
  platforms: [
    .iOS(.v15),
    .macOS(.v11)
  ],
  products: ANProducts.all,
  dependencies: ANDependencies.all,
  targets: ANTargets.all
)

// MARK: - Targets
private enum ANTargets {
  static let all: [Target] = ANTargets.alCore
  + ANTargets.common
  + ANTargets.entities
  + ANTargets.localization
  + ANTargets.prayerDetails
  + ANTargets.prayersClient
  + ANTargets.home
  + ANTargets.assets
}

private extension ANTargets {
  static let alCore: [Target] = [
    .target(
      name: "AlCore",
      dependencies: [
        "Entities",
        "Localization",
        "Common",
        "PrayerDetails",
        "PrayersClient",
        "Home",
        "Assets",
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
}
private extension ANTargets {
  static let assets: [Target] = [
    .target(
      name: "Assets",
      resources: [
        .process("Resources")
      ]
    )
  ]
  
  static let prayerDetails: [Target] = [
    .target(
      name: "PrayerDetails",
      dependencies: [
        "Common",
        "Entities",
        "Localization",
        "PrayersClient",
        .product(name: "Drawer", package: "swiftui-drawer"),
        .product(name: "Core", package: "OrdiCore"),
      ]
    )
  ]
  
  static let home: [Target] = [
    .target(
      name: "Home",
      dependencies: [
        "Common",
        "Entities",
        "Localization",
        "PrayerDetails",
        .product(name: "Core", package: "OrdiCore"),
      ]
    )
  ]
  
  static let prayersClient: [Target] = [
    .target(
      name: "PrayersClient",
      dependencies: [
        "Entities",
        "Localization",
        .product(name: "Core", package: "OrdiCore"),
        .product(name: "ComposableCoreLocation", package: "composable-core-location"),
        .product(name: "Adhan", package: "adhan-swift"),
        .product(name: "RealmSwift", package: "realm-swift")
      ],
      resources: [.process("Resources")]
    )
  ]
  
  static let common: [Target] = [
    .target(
      name: "Common",
      dependencies: [
        "Entities",
        "PrayersClient",
        .product(name: "Core", package: "OrdiCore"),
        .product(name: "ComposableCoreLocation", package: "composable-core-location"),
        .product(name: "Inject", package: "Inject"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "TCACoordinators", package: "TCACoordinators")
      ]
    )
  ]
  
  static let localization: [Target] = [
    .target(
      name: "Localization",
      dependencies: [],
      resources: [
        .process("Resources")
      ]
    ),
  ]
  
  static let entities: [Target] = [
    .target(
      name: "Entities",
      dependencies: [
        "Localization",
        "Assets",
        .product(name: "RealmSwift", package: "realm-swift"),
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
}


// MARK: - Dependencies
private enum ANDependencies {
  static let all: [Package.Dependency] = ordiCore
  + pointFree
  + quickAndNimble
  + inject
  + home
}
private extension ANDependencies {
  static let ordiCore: [Package.Dependency] = [
    .package(path: "../OrdiCore")
  ]
  
  static let pointFree: [Package.Dependency] = [
    .package(
      url: "https://github.com/pointfreeco/composable-core-location",
      .upToNextMajor(from: .init(0, 1, 0))
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      .upToNextMajor(from: .init(1, 9, 0))
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      branch: "main"
    ),
    .package(
      url: "https://github.com/johnpatrickmorgan/TCACoordinators",
      .upToNextMajor(from: .init(0, 2, 0))
    )
  ]
  
  static let quickAndNimble: [Package.Dependency] = [
    .package(
      url: "https://github.com/Quick/Quick",
      .upToNextMajor(from: .init(4, 0, 0))
    ),
    .package(
      url: "https://github.com/Quick/Nimble",
      .upToNextMajor(from: .init(9, 2, 1))
    )
  ]
  
  static let inject: [Package.Dependency] = [
    .package(
      url: "https://github.com/krzysztofzablocki/Inject",
      .upToNextMajor(from: .init(1, 2, 1))
    )
  ]
  
  static let home: [Package.Dependency] = [
    .package(
      url: "https://github.com/batoulapps/adhan-swift",
      branch: "main"
    ),
    .package(
      url: "https://github.com/maustinstar/swiftui-drawer",
      branch: "master"
    ),
    .package(
        url: "https://github.com/realm/realm-swift",
        .upToNextMinor(from: .init(10, 28, 6))
    )
  ]
}


// MARK: - Products
private enum ANProducts {
  static let all: [PackageDescription.Product] = [
    ANProducts.product(name: "AlCore"),
    ANProducts.product(name: "Entities"),
    ANProducts.product(name: "Localization"),
    ANProducts.product(name: "Common"),
    ANProducts.product(name: "PrayerDetails"),
    ANProducts.product(name: "PrayersClient"),
    ANProducts.product(name: "Home"),
    ANProducts.product(name: "Assets"),
  ]

  static func product(name: String) -> PackageDescription.Product {
    .library(
      name: name,
      targets: [name]
    )
  }
}
