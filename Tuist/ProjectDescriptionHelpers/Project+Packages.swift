import ProjectDescription

public extension Array where Element == TargetDependency {
    static let mainAppPackages: [TargetDependency] = [
        .external(name: "Alamofire"),
        .external(name: "Factory"),
        .external(name: "FontBlaster"),
        .external(name: "GRDB"),
        .external(name: "Inject"),
        .external(name: "Lottie"),
        .external(name: "Pulse"),
        .external(name: "PulseUI"),
        .external(name: "Sentry"),
        .external(name: "ComposableArchitecture"),
        .external(name: "SwiftUIIntrospect"),
        .external(name: "SwiftDate"),
    ]

    static let mainAppDependencies: [TargetDependency] = mainAppPackages
}
