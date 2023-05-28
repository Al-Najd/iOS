// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataSources",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DataSources",
            targets: ["DataSources"]),
    ],
    dependencies: [
        .package(path: "../Alamofire/"),
        .package(path: "../SwiftKeychainWrapper/"),
        .package(path: "../Loggers/"),
        .package(path: "../Configs/")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DataSources",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SwiftKeychainWrapper", package: "SwiftKeychainWrapper"),
                .product(name: "Loggers", package: "Loggers"),
                .product(name: "Configs", package: "Configs"),
            ]),
    ])
