import ProjectDescription

let config = Config(
    plugins: [
        //        .local(path: .relativeToManifest("../../Plugins/AlNajd")),
        .git(url: "https://github.com/haifengkao/SwiftUITemplate", tag: "2.2.0")
    ])
