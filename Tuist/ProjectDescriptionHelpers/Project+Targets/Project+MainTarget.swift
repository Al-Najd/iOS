import ProjectDescription

public extension Target {
    static let mainTarget = Target.target(
        name: "AlNajd",
        destinations: .iOS,
        product: .app,
        bundleId: ProjectConfigs.bundleId,
        deploymentTargets: .iOS(ProjectConfigs.iOSLevel),
        sources: [
            "Al Najd/**",
        ],
        resources: [
            "Al Najd/Resources/**"
        ],
        scripts: .mainAppScripts,
        dependencies: .mainAppDependencies,
        settings: .mainAppSettings
    )
}
