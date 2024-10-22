import Foundation
import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .upToNextMinor("16"),
    swiftVersion: "5.10",
    generationOptions: .options(enforceExplicitDependencies: true)
)
