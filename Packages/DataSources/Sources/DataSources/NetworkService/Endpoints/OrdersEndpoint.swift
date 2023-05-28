//
//  OrdersEndpoint.swift
//  CAFU
//
//  Created by Ahmed Allam on 17/10/2022.
//

import Foundation

// MARK: - OrderStatusesFilter

public enum OrderStatusesFilter: String {
    case ongoing, completed, cancelled
}

// MARK: - OrdersEndpoint

public enum OrdersEndpoint {
    case lowChargeOrder
    case orderStatuses(filter: OrderStatusesFilter)
    case orderStatus(id: Int)
    case create(_ parameters: Encodable)
    case cancel(id: Int)
    case orderWith(id: Int)
    case retry(id: Int, parameters: Encodable)
}

// MARK: Endpoint

extension OrdersEndpoint: Endpoint {
    public var path: String {
        switch self {
        case .lowChargeOrder:
            return "orders/requests/latest"
        case .orderStatuses:
            return "orders/statuses"
        case .orderStatus(let id):
            return "orders/\(id)/status"
        case .create:
            return "orders"
        case .cancel(let id):
            return "orders/\(id)/cancel"
        case .orderWith(let id):
            return "orders/\(id)"
        case .retry(let id,_):
            return "orders/\(id)/charge"
        }
    }

    public var task: EncodingTask {
        switch self {
        case .create(let params),
             .retry(_, let params):
            return .body(params)
        case .cancel,
             .orderStatus,
             .lowChargeOrder,
             .orderWith:
            return .plain
        case .orderStatuses(filter: let filter):
            return .url(["status": filter.rawValue])
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .lowChargeOrder,
             .orderStatuses,
             .orderStatus,
             .orderWith:
            return .GET
        case .create,
             .retry:
            return .POST
        case .cancel:
            return .PATCH
        }
    }

    public var authenticationRequired: Bool {
        true
    }
}
