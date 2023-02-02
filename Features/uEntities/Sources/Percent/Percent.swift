import Foundation

public struct Percent: Equatable {
    public var value: Double

    public func display() -> String {
        PercentageFormatter().string(from: NSNumber(value: value / 100)) ?? "%\(value / 100)"
    }

    public init(value: Int) {
        self.value = Double(value)
    }

    public init(value: Double) {
        self.value = value
    }
}
