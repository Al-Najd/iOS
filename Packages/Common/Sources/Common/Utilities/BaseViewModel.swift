//
//  BaseViewModel.swift
//  CAFU
//
//  Created by Ahmed Ramy on 03/10/2022.
//

import Combine

open class BaseViewModel {
    public var cancellables = Set<AnyCancellable>()

    public init() { }
}
