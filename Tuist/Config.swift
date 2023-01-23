import ProjectDescription

let config = Config(
    plugins: [
        .git(url: "https://github.com/haifengkao/SwiftUITemplate", tag: "2.2.0"),
        .local(path: .relativeToManifest("../../Plugins/AlNajd"))
    ])
