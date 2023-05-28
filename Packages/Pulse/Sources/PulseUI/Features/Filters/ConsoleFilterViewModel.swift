// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

import Combine
import CoreData
import Pulse
import SwiftUI

final class ConsoleFiltersViewModel: ObservableObject {
    @Published var mode: ConsoleMode = .all
    @Published var options = ConsoleDataSource.PredicateOptions()

    var criteria: ConsoleFilers {
        get { options.filters }
        set { options.filters = newValue }
    }

    let defaultCriteria: ConsoleFilers

    // TODO: Refactor
    let entities = CurrentValueSubject<[NSManagedObject], Never>([])

    init(options: ConsoleDataSource.PredicateOptions) {
        self.options = options
        defaultCriteria = options.filters
    }

    // MARK: Helpers

    func isDefaultFilters(for mode: ConsoleMode) -> Bool {
        guard criteria.shared == defaultCriteria.shared else { return false }
        if mode == .network {
            return criteria.network == defaultCriteria.network
        } else {
            return criteria.messages == defaultCriteria.messages
        }
    }

    func select(sessions: Set<UUID>) {
        criteria.shared.sessions.selection = sessions
    }

    func resetAll() {
        criteria = defaultCriteria
    }
}
