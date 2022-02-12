// swift-tools-version:5.5
import PackageDescription

let calendar: [Target] = [
    .target(
        name: "Calendar",
        dependencies: [
            "Entities",
            .product(name: "Core", package: "OrdiCore")
        ]
    ),
    .testTarget(
        name: "CalendarTests",
        dependencies: [
            "Calendar",
            .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        ],
        path: "Tests/Calendar"
    )
]

let localization: [Target] = [
    .target(
        name: "Localization",
        dependencies: [],
        resources: [
          .process("Resources")
        ]
    ),
]

let entities: [Target] = [
    .target(
        name: "Entities",
        dependencies: [
            .product(name: "Core", package: "OrdiCore")
        ]
    )
]

let daySlider: [Target] = [
    .target(
        name: "DaySlider",
        dependencies: [
            "Entities",
            .product(name: "Core", package: "OrdiCore")
        ]
    )
]

let schedule: [Target] = [
    .target(
        name: "Schedule",
        dependencies: [
            "Calendar",
            "Entities",
            .product(name: "Core", package: "OrdiCore")
        ]
    ),
    .testTarget(
        name: "ScheduleTests",
        dependencies: [
            "Schedule",
            .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        ],
        path: "Tests/Schedule"
    )
]

let dashboard: [Target] = [
    .target(
        name: "Dashboard",
        dependencies: [
            "Entities",
            "Localization",
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

let alCore: [Target] = [
    .target(
        name: "AlCore",
        dependencies: [
            "Dashboard",
            "Calendar",
            "Entities",
            "DaySlider",
            "Schedule",
            "Localization",
            .product(name: "Core", package: "OrdiCore")
        ]
    )
]

let package = Package(
  name: "AlNajd",
  defaultLocalization: "ar",
  platforms: [
    .iOS(.v15),
    .macOS(.v11)
  ],
  products: [
    .library(name: "AlCore", targets: ["AlCore"]),
    .library(name: "Entities", targets: ["Entities"]),
    .library(name: "Calendar", targets: ["Calendar"]),
    .library(name: "DaySlider", targets: ["DaySlider"]),
    .library(name: "Schedule", targets: ["Schedule"]),
    .library(name: "Dashboard", targets: ["Dashboard"]),
    .library(name: "Localization", targets: ["Localization"])
  ],
  dependencies: [
    .package(path: "../OrdiCore"),
    .package(
        url: "https://github.com/pointfreeco/swift-composable-architecture",
        .upToNextMajor(from: .init(1, 9, 0))
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      .upToNextMajor(from: .init(1, 9, 0))
    ),
    .package(
        url: "https://github.com/Quick/Quick",
        .upToNextMajor(from: .init(4, 0, 0))
    ),
    .package(
        url: "https://github.com/Quick/Nimble",
        .upToNextMajor(from: .init(9, 2, 1))
    )
  ],
  targets: alCore
  + entities
  + daySlider
  + calendar
  + schedule
  + dashboard
  + localization
)
