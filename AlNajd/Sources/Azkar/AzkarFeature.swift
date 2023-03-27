//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 26/03/2023.
//

import ComposableArchitecture
import Entities
import Common

public struct AzkarFeature: ReducerProtocol {
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        
        }

        return .none
    }
}

extension AzkarFeature {
    public struct State: Equatable {
        let morningAzkar: IdentifiedArrayOf<ANAzkar>
        let nightAzkar: IdentifiedArrayOf<ANAzkar>
    }
}

extension AzkarFeature {
    public enum Action {

    }
}
