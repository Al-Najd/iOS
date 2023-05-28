// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

import Combine
import CoreData
import Pulse
import SwiftUI

public extension ConsoleView {
    init(store: LoggerStore = .shared, mode: ConsoleMode = .all) {
        self.init(environment: .init(store: store, mode: mode))
    }
}

public extension ConsoleView {
    @available(*, deprecated, message: "Please use the default initializer and pass the mode instead")
    static func network(store: LoggerStore = .shared) -> ConsoleView {
        ConsoleView(environment: .init(store: store, mode: .network))
    }
}
