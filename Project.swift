import MyPlugin
import ProjectDescription
import ProjectDescriptionHelpers
import SwiftUITemplate

let project: Project = {
    GenerationConfig.default.platform = platform

    return Project(
        name: "AlNajd",
        organizationName: "Al Najd",
        targets: modules.allProjectTargets)
}()