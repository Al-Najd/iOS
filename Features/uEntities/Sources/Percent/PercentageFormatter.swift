import Foundation

public class PercentageFormatter: NumberFormatter {
    override public init() {
        super.init()
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        numberStyle = .percent
    }
}
