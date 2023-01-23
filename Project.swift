import MyPlugin
import ProjectDescription
import ProjectDescriptionHelpers
import SwiftUITemplate

let project: Project = {
    GenerationConfig.default.platform = platform
    let uFeatures = modules.allProjectTargets

    let mainAppTargets = Target.makeAppTargets(
        name: "iOS",
        displayName: "Al Najd",
        dependencies: Module.Reminders.allProjectTargets.map { $0.name },
        hasResources: true)

    return Project(
        name: "AlNajd",
        organizationName: "Al Najd",
        targets: mainAppTargets + uFeatures)
}()
