import ProjectDescription

public extension Settings {
    static let mainAppSettings = Settings.settings(
        base: [
            "MARKETING_VERSION": .string(ProjectConfigs.version),
            "CURRENT_PROJECT_VERSION": .string(ProjectConfigs.buildNumber),
            "VERSIONING_SYSTEM": .string("apple-generic"),
            "DEVELOPMENT_TEAM": .string("793K46RDR4"),
            "TARGETED_DEVICE_FAMILY": .string("1"),
            "SWIFT_STRICT_CONCURRENCY": .string("complete"),
            "FRAMEWORK_SEARCH_PATHS": .string("$(inherited)"),
            "STRIP_STYLE": .string("all"),
            "COPY_PHASE_STRIP": .string("false"),
        ],
        configurations: [
            .debug(
                name: .debug,
                xcconfig: .relativeToRoot("Al Najd/Resources/Build Configs/Debug.xcconfig")
            ),
            .debug(
                name: "Alpha",
                xcconfig: .relativeToRoot("Al Najd/Resources/Build Configs/Alpha.xcconfig")
            ),
            .release(
                name: "Beta",
                xcconfig: .relativeToRoot("Al Najd/Resources/Build Configs/Beta.xcconfig")
            ),
            .release(
                name: .release,
                xcconfig: .relativeToRoot("Al Najd/Resources/Build Configs/Release.xcconfig")
            ),
        ]
    )
}
