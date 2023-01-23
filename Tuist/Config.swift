import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugins/uFeature")),
        .local(path: .relativeToRoot("Plugins/AlNajd"))
    ])
