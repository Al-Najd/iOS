import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "AlNajd",
    options: .options(disableSynthesizedResourceAccessors: true),
    settings: .mainAppSettings,
    targets: [
        .mainTarget,
    ],
    schemes: [.alNajdScheme]
)
