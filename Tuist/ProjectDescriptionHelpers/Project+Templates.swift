import ProjectDescription

//  Based on the Tuist uFeatures example project (https://github.com/tuist/microfeatures-example)

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://tuist.io/docs/usage/helpers/

let bundleIdentifier = "com.nerdor.alnajd"

// MARK: - uFeatureTarget

public enum uFeatureTarget {
    case package
    case tests
    case examples
    case testing
    case thirdParty
}

public extension Target {
    static func makeAppTargets(
        name: String,
        displayName: String,
        dependencies: [String] = [],
        hasResources: Bool = false,
        testDependencies: [String] = []) -> [Target] {
        let targetDependencies: [TargetDependency] = dependencies.map { .sdk(name: $0, type: .framework) }
        return [
            Target(
                name: name,
                platform: .iOS,
                product: .app,
                productName: displayName,
                bundleId: "\(bundleIdentifier).\(name)",
                infoPlist: InfoPlist.extendingDefault(
                    with: [
                        "UILaunchStoryboardName": .string("Launchscreen")
                    ]),
                sources: ["Projects/\(name)/Sources/**/*.swift"],
                resources: hasResources ? ["Projects/\(name)/Resources/**/*"] : [],
                dependencies: targetDependencies),
            Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "\(bundleIdentifier).\(name)Tests",
                infoPlist: .default,
                sources: ["Projects/\(name)/Tests/**/*.swift"],
                dependencies: [
                    .target(name: name),
                    .xctest,
                ] + testDependencies.map { .target(name: $0) })
        ]
    }

    static func makeFrameworkTargets(
        name: String,
        dependencies: [String] = [],
        testDependencies: [String] = [],
        targets: Set<uFeatureTarget> = Set([.package, .tests, .examples, .testing]),
        packages: [String] = [],
        dependsOnXCTest: Bool = false,
        externalDependencies: [TargetDependency] = []) -> [Target] {
        // Test dependencies
        let targetTestDependencies: [TargetDependency] = [
            .target(name: "\(name)"),
            .xctest,
        ] + testDependencies.map { .target(name: $0) }

        // Target dependencies
        var targetDependencies: [TargetDependency] = dependencies.map { .target(name: $0) }
        targetDependencies.append(contentsOf: packages.map { .package(product: $0) })
        if dependsOnXCTest {
            targetDependencies.append(.xctest)
        }

        // Targets
        var projectTargets: [Target] = []
        if targets.contains(.package) {
            targetDependencies.append(contentsOf: externalDependencies)

            projectTargets.append(Target(
                name: name,
                platform: .iOS,
                product: .framework,
                bundleId: "\(bundleIdentifier).\(name)",
                infoPlist: .default,
                sources: ["Projects/Packages/\(name)/Sources/**/*.swift"],
                dependencies: targetDependencies))
        }
        if targets.contains(.tests) {
            projectTargets.append(Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "\(bundleIdentifier).\(name)Tests",
                infoPlist: .default,
                sources: ["Projects/Packages/\(name)/Tests/**/*.swift"],
                dependencies: targetTestDependencies))
        }
        return projectTargets
    }
}

/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, platform: Platform, additionalTargets: [String]) -> Project {
        var targets = makeAppTargets(
            name: name,
            platform: platform,
            dependencies: additionalTargets.map { TargetDependency.target(name: $0) })
        targets += additionalTargets.flatMap { makeFrameworkTargets(name: $0, platform: platform) }
        return Project(
            name: name,
            organizationName: "tuist.io",
            targets: targets)
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
        let sources = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "io.tuist.\(name)",
            infoPlist: .default,
            sources: ["Targets/\(name)/Sources/**"],
            resources: [],
            dependencies: [])
        let tests = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "io.tuist.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            resources: [],
            dependencies: [.target(name: name)])
        return [sources, tests]
    }

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
        ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "io.tuist.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies)

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "io.tuist.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}
