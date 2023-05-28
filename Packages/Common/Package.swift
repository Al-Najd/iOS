// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Common",
            targets: ["Common"]),
    ],
    dependencies: [
        .package(path: "../PhoneNumberKit/"),
        .package(path: "../Loggers/"),
        .package(path: "../Content/"),
        .package(path: "../Configs/"),
        .package(path: "../Factory/"),
        .package(path: "../lottie-ios/"),
        .package(path: "../Navigation/"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Common",
            dependencies: [
                .product(name: "PhoneNumberKit", package: "PhoneNumberKit"),
                .product(name: "Content", package: "Content"),
                .product(name: "ContentEV", package: "Content"),
                .product(name: "Loggers", package: "Loggers"),
                .product(name: "Factory", package: "Factory"),
                .product(name: "Configs", package: "Configs"),
                .product(name: "Lottie", package: "lottie-ios"),
                .product(name: "Navigation", package: "Navigation")
            ], resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "CommonTests",
            dependencies: [
                .target(name: "Common")
            ])
    ])
