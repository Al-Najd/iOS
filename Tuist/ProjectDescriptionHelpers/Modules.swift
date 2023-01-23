import ProjectDescription
import SwiftUITemplate


private extension Module {
    static var iOSApp: Module {
        .uFeature(name: "iOS", targets: [
            .exampleApp: .resourcesOnly,
            .unitTests: .default,
            .framework: .hasDependencies([
                Reminders
            ])
        ])
    }
}

// MARK: - Packages
private extension Module {
    static var TCA: Module {
        .package(
            name: "ComposableArchitecture",
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            requirement: .exact(.init(0, 49, 2)))
    }
}

// MARK: - Microfeatures
private extension Module {
    static var uDesignSystem: Module {
        .uFeature(
            name: "uDesignSystem",
            targets: [
                .framework: .resourcesOnly
            ])
    }

    static var uContent: Module {
        .uFeature(
            name: "uContent",
            targets: [.framework: .default])
    }
}

// MARK: - Services
private extension Module {
    static var uDatabase: Module {
        .uFeature(
            name: "uDatabase",
            targets: [.framework: .default])
    }

    static var uFluentDBService: Module {
        .uFeature(
            name: "uFluentDBService",
            targets: [
                .framework: .hasDependencies([uDatabase])
            ])
    }

    static var uAnalyticsService: Module {
        .uFeature(
            name: "uAnalyticsService",
            targets: [
                .framework: .hasDependencies([uDatabase])
            ])
    }

    static var uDashboardService: Module {
        .uFeature(
            name: "uDashboardService",
            targets: [
                .framework: .hasDependencies([uAnalyticsService])
            ])
    }

    static var uRewardsService: Module {
        .uFeature(
            name: "uRewardsService",
            targets: [
                .framework: .hasDependencies([uFluentDBService])
            ])
    }

    static var uDuaaService: Module {
        .uFeature(
            name: "uDuaaService",
            targets: [.framework: .hasDependencies([uFluentDBService])])
    }

    static var uTasksService: Module {
        .uFeature(
            name: "uTasksService",
            targets: [
                .framework: .hasDependencies([uFluentDBService])
            ])
    }
}

// MARK: - Features
private extension Module {
    static var Reminders: Module {
        .uFeature(
            name: "Reminders",
            targets: [
                .exampleApp: .hasDependencies([
                    TCA,
                    uDesignSystem,
                ]),
                .framework: .hasDependencies([
                    TCA,
                    uDesignSystem,
                ])
            ])
    }
}

public let modules: [Module] = [
    Module.iOSApp,
    Module.uDesignSystem,
    Module.uContent,
    Module.uDatabase,
    Module.uFluentDBService,
    Module.uAnalyticsService,
    Module.uDashboardService,
    Module.uRewardsService,
    Module.uDuaaService,
    Module.uTasksService,
    Module.Reminders,
]

public let platform: Platform = .iOS

// MARK: - MicroFeatureGroup

enum MicroFeatureGroup: String {
    case services = "Services"
    case ui = "UI"
}