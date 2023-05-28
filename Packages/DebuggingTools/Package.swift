// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DebuggingTools",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DebuggingTools",
            targets: ["DebuggingTools"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../Pulse/"),
        .package(path: "../DataSources/"),
        .package(path: "../Common/"),
        .package(path: "../Configs/"),
        .package(path: "../Navigation/"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DebuggingTools",
            dependencies: [
                .product(name: "Configs", package: "Configs"),
                .product(name: "Navigation", package: "Navigation"),
                .product(name: "Pulse", package: "Pulse"),
                .product(name: "PulseUI", package: "Pulse"),
                .product(name: "Common", package: "Common"),
                .product(name: "DataSources", package: "DataSources"),
            ]),
    ])
