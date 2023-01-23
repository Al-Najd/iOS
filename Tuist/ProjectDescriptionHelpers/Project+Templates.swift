//  Based on the Tuist uFeatures example project (https://github.com/tuist/microfeatures-example)
import ProjectDescription

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
        let targetDependencies: [TargetDependency] = dependencies.map { .package(product: $0) }
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
