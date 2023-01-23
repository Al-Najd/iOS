import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture",requirement: .exact(.init(0, 49, 2))),
    ],
    platforms: [.iOS])