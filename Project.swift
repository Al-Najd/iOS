import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

func targets() -> [Target] {
    var targets: [Target] = []
    targets += Target.makeAppTargets(
        name: "iOS",
        displayName: "AlNajd",
        dependencies: ["Reminders"],
        testDependencies: [])
    return targets
}

let project = Project(
    name: "AlNajd",
    packages: [
        .package(path: "Projects/Packages/uDesignSystem"),
        .package(path: "Projects/Packages/uContent"),
        .package(path: "Projects/Packages/uDatabase"),
        .package(path: "Projects/Packages/uFluentDBService"),
        .package(path: "Projects/Packages/uAnalyticsService"),
        .package(path: "Projects/Packages/uDashboardService"),
        .package(path: "Projects/Packages/uRewardsService"),
        .package(path: "Projects/Packages/uDuaaService"),
        .package(path: "Projects/Packages/uTasksService"),
        .package(path: "Projects/Packages/uRemindersKit"),
        .package(path: "Projects/Packages/uRemindersUI"),
        .package(path: "Projects/Packages/Reminders"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .branch("main"))
    ],
    targets: targets())
