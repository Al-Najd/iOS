// The MIT License (MIT)
//
// Copyright (c) 2020–2023 Alexander Grebenyuk (github.com/kean).

import Pulse
import SwiftUI

// MARK: - NetworkRequestInfoCell

struct NetworkRequestInfoCell: View {
    let viewModel: NetworkRequestInfoCellViewModel

    var body: some View {
        NavigationLink(destination: destinationRequestDetails) {
            contents
        }
    }

    private var contents: some View {
        (Text(viewModel.httpMethod).fontWeight(.semibold).font(.callout.smallCaps()) + Text(" ") + Text(viewModel.url))
            .lineLimit(4)
            .font(.callout)
    }

    private var destinationRequestDetails: some View {
        NetworkDetailsView(title: "Request") { viewModel.render() }
    }
}

// MARK: - NetworkRequestInfoCellViewModel

final class NetworkRequestInfoCellViewModel {
    let httpMethod: String
    let url: String
    let render: () -> NSAttributedString

    init(task: NetworkTaskEntity) {
        httpMethod = task.httpMethod ?? "GET"
        url = task.url ?? "–"
        render = {
            TextRenderer(options: .sharing).make { $0.render(task, content: .all) }
        }
    }

    init(transaction: NetworkTransactionMetricsEntity) {
        httpMethod = transaction.request.httpMethod ?? "GET"
        url = transaction.request.url ?? "–"
        render = { TextRenderer(options: .sharing).make { $0.render(transaction) } }
    }
}

#if DEBUG
struct NetworkRequestInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ForEach(MockTask.allEntities, id: \.objectID) { task in
                    NetworkRequestInfoCell(viewModel: .init(task: task))
                }
            }
            #if os(macOS)
            .frame(width: 260)
            #endif
        }
    }
}
#endif
