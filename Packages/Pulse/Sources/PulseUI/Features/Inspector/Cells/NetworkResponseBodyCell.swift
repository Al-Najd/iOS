// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

import Pulse
import SwiftUI

// MARK: - NetworkResponseBodyCell

struct NetworkResponseBodyCell: View {
    let viewModel: NetworkResponseBodyCellViewModel

    var body: some View {
        NavigationLink(destination: destination) {
            NetworkMenuCell(
                icon: "arrow.down.circle.fill",
                tintColor: .indigo,
                title: "Response Body",
                details: viewModel.details)
        }
        .foregroundColor(viewModel.isEnabled ? nil : .secondary)
        .disabled(!viewModel.isEnabled)
    }

    private var destination: some View {
        NetworkInspectorResponseBodyView(viewModel: viewModel.detailsViewModel)
    }
}

// MARK: - NetworkResponseBodyCellViewModel

struct NetworkResponseBodyCellViewModel {
    let details: String
    let isEnabled: Bool
    let detailsViewModel: NetworkInspectorResponseBodyViewModel

    init(task: NetworkTaskEntity) {
        let size = task.responseBodySize
        details = size > 0 ? ByteCountFormatter.string(fromByteCount: size) : "Empty"
        isEnabled = size > 0
        detailsViewModel = NetworkInspectorResponseBodyViewModel(task: task)
    }
}
