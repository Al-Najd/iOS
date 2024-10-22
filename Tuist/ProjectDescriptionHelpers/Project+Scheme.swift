import ProjectDescription

public extension Scheme {
    static let alNajdScheme: Scheme = .scheme(
        name: "AlNajd",
        shared: true,
        buildAction: .buildAction(targets: ["AlNajd"])
    )
}
