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
  + ANTargets.daySlider
  + ANTargets.calendar
  + ANTargets.schedule
  + ANTargets.dashboard
  + ANTargets.localization
  + ANTargets.settings
  + ANTargets.onboarding
}
private extension ANTargets {
  static let alCore: [Target] = [
    .target(
      name: "AlCore",
      dependencies: [
        "Dashboard",
        "Calendar",
        "Entities",
        "DaySlider",
        "Schedule",
        "Localization",
        "Common",
        "Settings",
        "Onboarding",
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
}
private extension ANTargets {
  static let onboarding: [Target] = [
    .target(
      name: "Onboarding",
      dependencies: [
        "Common",
        "Entities",
        "Localization",
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
  static let settings: [Target] = [
    .target(
      name: "Settings",
      dependencies: [
        "Common",
        "Entities",
        "Localization",
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
  
  static let common: [Target] = [
    .target(
      name: "Common",
      dependencies: [
        "Entities",
        .product(name: "Core", package: "OrdiCore"),
        .product(name: "ComposableCoreLocation", package: "composable-core-location")
      ],
      resources: [
        .process("Resources")
      ]
    )
  ]
  
  static let calendar: [Target] = [
    .target(
      name: "Calendar",
      dependencies: [
        "Entities",
        "Common",
        .product(name: "Core", package: "OrdiCore")
      ]
    ),
    .testTarget(
      name: "CalendarTests",
      dependencies: [
        "Calendar",
        "Common",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ],
      path: "Tests/Calendar"
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
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
  
  static let daySlider: [Target] = [
    .target(
      name: "DaySlider",
      dependencies: [
        "Entities",
        "Common",
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
  
  static let schedule: [Target] = [
    .target(
      name: "Schedule",
      dependencies: [
        "Calendar",
        "Entities",
        "Common",
        .product(name: "Core", package: "OrdiCore")
      ]
    ),
    .testTarget(
      name: "ScheduleTests",
      dependencies: [
        "Schedule",
        "Common",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ],
      path: "Tests/Schedule"
    )
  ]
  
  static let dashboard: [Target] = [
    .target(
      name: "Dashboard",
      dependencies: [
        "Entities",
        "Localization",
        "Common",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Core", package: "OrdiCore")
      ]
    ),
    .testTarget(
      name: "DashboardTests",
      dependencies: [
        "Dashboard",
        .product(name: "Quick", package: "Quick"),
        .product(name: "Nimble", package: "Nimble"),
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ],
      path: "Tests/Dashboard"
    )
  ]
}


// MARK: - Dependencies
private enum ANDependencies {
  static let all: [Package.Dependency] = ordiCore
  + pointFree
  + quickAndNimble
}

private extension ANDependencies {
  static let ordiCore: [Package.Dependency] = [
    .package(path: "../OrdiCore")
  ]
  
  static let pointFree: [Package.Dependency] = [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      .upToNextMajor(from: .init(0, 33, 1))
    ),
    .package(
      url: "https://github.com/pointfreeco/composable-core-location",
      .upToNextMajor(from: .init(0, 1, 0))
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      .upToNextMajor(from: .init(1, 9, 0))
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
}


// MARK: - Products
private enum ANProducts {
  static let all = alCore
  + entities
  + calendar
  + daySlider
  + schedule
  + dashboard
  + localization
  + common
  + settings
  + onboarding
}
private extension ANProducts {
  static let onboarding: [PackageDescription.Product] = [
    .library(
      name: "Onboarding",
      targets: ["Onboarding"]
    )
  ]
  
  static let settings: [PackageDescription.Product] = [
    .library(
      name: "Settings",
      targets: ["Settings"]
    )
  ]
  
  static let alCore: [PackageDescription.Product] = [
    .library(
      name: "AlCore",
      targets: ["AlCore"]
    )
  ]
  static let entities: [PackageDescription.Product] = [
    .library(
      name: "Entities",
      targets: ["Entities"]
    )
  ]
  static let calendar: [PackageDescription.Product] = [
    .library(
      name: "Calendar",
      targets: ["Calendar"]
    )
  ]
  static let daySlider: [PackageDescription.Product] = [
    .library(
      name: "DaySlider",
      targets: ["DaySlider"]
    )
  ]
  static let schedule: [PackageDescription.Product] = [
    .library(
      name: "Schedule",
      targets: ["Schedule"]
    )
  ]
  static let dashboard: [PackageDescription.Product] = [
    .library(
      name: "Dashboard",
      targets: ["Dashboard"]
    )
  ]
  static let localization: [PackageDescription.Product] = [
    .library(
      name: "Localization",
      targets: ["Localization"]
    )
  ]
  
  static let common: [PackageDescription.Product] = [
    .library(
      name: "Common",
      targets: ["Common"]
    )
  ]
}
