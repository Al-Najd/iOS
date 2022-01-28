// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "AlNajd",
  platforms: [
    .iOS(.v15),
    .macOS(.v11)
  ],
  products: [
    .library(name: "Entities", targets: ["Entities"]),
    .library(name: "Calendar", targets: ["Calendar"])
  ],
  dependencies: [
    .package(path: "../OrdiCore")
  ],
  targets: [
    .target(
      name: "Entities",
      dependencies: [
        .product(name: "Core", package: "OrdiCore")
      ]
    ),
    .target(
      name: "Calendar",
      dependencies: [
        .product(name: "Core", package: "OrdiCore")
      ]
    )
  ]
)
