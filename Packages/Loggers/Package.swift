// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Loggers",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Loggers", targets: ["Loggers"]),
    ],
    dependencies: [
        .package(path: "../Pulse/"),
        .package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.4.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Loggers",
            dependencies: [
                .product(name: "Pulse", package: "Pulse"),
                .product(name: "Sentry", package: "sentry-cocoa"),
            ])
    ])
