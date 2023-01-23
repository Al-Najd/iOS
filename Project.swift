import MyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

//               +-------------+
//               |             |
//               |     App     | Contains AlNajd App target and AlNajd unit-test target
//               |             |
//        +------+-------------+-------+
//        |         depends on         |
//        |                            |
// +----v-----+                   +-----v-----+
// |          |                   |           |
// |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
// |          |                   |           |
// +----------+                   +-----------+
//

// MARK: - Project

func targets() -> [Target] {
    var targets: [Target] = []
    targets += Target.makeAppTargets(
        name: "AlNajd",
        displayName: "AlNajd",
        dependencies: ["Reminders"],
        testDependencies: [])

    // MARK: - UI Based
    targets += Target.makeFrameworkTargets(name: "uDesignSystem")
    targets += Target.makeFrameworkTargets(name: "uContent")

    // MARK: - Logic Based
    targets += Target.makeFrameworkTargets(name: "uDatabase")
    targets += Target.makeFrameworkTargets(name: "uFluentDBService", dependencies: ["uDatabase"])
    targets += Target.makeFrameworkTargets(name: "uAnalyticsService", dependencies: ["uFluentDBService"])
    targets += Target.makeFrameworkTargets(name: "uDashboardService", dependencies: ["uAnalyticsService"])

    targets += Target.makeFrameworkTargets(name: "uRewardsService", dependencies: ["uFluentDBService"])
    targets += Target.makeFrameworkTargets(name: "uDuaaService", dependencies: ["uFluentDBService"])
    targets += Target.makeFrameworkTargets(name: "uTasksService", dependencies: ["uFluentDBService"])

    // MARK: - Feature Based Logic
    targets += Target.makeFrameworkTargets(name: "uRemindersKit")
    targets += Target.makeFrameworkTargets(name: "uRemindersUI", dependencies: ["uRemindersKit"])

    // MARK: - Feature Based Dependency
    targets += Target.makeFrameworkTargets(name: "Reminders", dependencies: ["uRemindersUI", "uRemindersKit"])
    return targets
}

let project = Project(
    name: "AlNajd",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .branch("main"))
    ],
    settings: Settings(),
    targets: targets())
