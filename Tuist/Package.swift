// swift-tools-version: 5.10
@preconcurrency import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

let packageSettings = PackageSettings(
    productTypes: [
        "Alamofire": .framework,
        "Factory": .framework,
        "FontBlaster": .framework,
        "GRDB": .framework,
        "Inject": .framework,
        "Lottie": .framework,
        "Pulse": .framework,
        "PulseUI": .framework,
        "Sentry": .framework,
        "ComposableArchitecture": .framework,
        "SwiftUIIntrospect": .framework,
        "SwiftDate": .framework
    ],
    baseSettings: .settings(
        configurations: [
            .debug(name: .debug),
            .debug(name: "Alpha"),
            .release(name: "Beta"),
            .release(name: .release)
        ]
    )
)

#endif

let package = Package(
    name: "AlNajd",
    dependencies: [
        .package(url: "https://github.com/kean/Pulse", from: "5.1.2"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.10.1"),
        .package(url: "https://github.com/hmlongco/Factory", from: "2.4.1"),
        .package(url: "https://github.com/ArtSabintsev/FontBlaster", from: "5.0.0"),
        .package(url: "https://github.com/groue/GRDB.swift", from: "6.29.3"),
        .package(url: "https://github.com/krzysztofzablocki/Inject", from: "1.5.2"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.0"),
        .package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.17.1"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.1"),
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", from: "1.3.0"),
        .package(url: "https://github.com/malcommac/SwiftDate", from: "7.0.0")
    ]
)
