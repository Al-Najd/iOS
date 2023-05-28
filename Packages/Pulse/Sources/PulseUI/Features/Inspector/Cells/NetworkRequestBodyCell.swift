// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

import Pulse
import SwiftUI

// MARK: - NetworkRequestBodyCell

struct NetworkRequestBodyCell: View {
    let viewModel: NetworkRequestBodyCellViewModel

    var body: some View {
        NavigationLink(destination: destination) {
            NetworkMenuCell(
                icon: "arrow.up.circle.fill",
                tintColor: .blue,
                title: "Request Body",
                details: viewModel.details)
        }
        .foregroundColor(viewModel.isEnabled ? nil : .secondary)
        .disabled(!viewModel.isEnabled)
    }

    private var destination: some View {
        NetworkInspectorRequestBodyView(viewModel: viewModel.detailsViewModel)
    }
}

// MARK: - NetworkRequestBodyCellViewModel

struct NetworkRequestBodyCellViewModel {
    let details: String
    let isEnabled: Bool
    let detailsViewModel: NetworkInspectorRequestBodyViewModel

    init(task: NetworkTaskEntity) {
        let size = task.requestBodySize
        details = size > 0 ? ByteCountFormatter.string(fromByteCount: size) : "Empty"
        isEnabled = size > 0
        detailsViewModel = NetworkInspectorRequestBodyViewModel(task: task)
    }
}
