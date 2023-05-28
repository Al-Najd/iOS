// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

import Combine
import Pulse
import SwiftUI

final class UserSettings: ObservableObject {
    static let shared = UserSettings()

    @AppStorage("console-cell-line-limit")
    var lineLimit = 4

    @AppStorage("link-detection")
    var isLinkDetectionEnabled = false

    @AppStorage("sharing-output")
    var sharingOutput: ShareStoreOutput = .store
}
