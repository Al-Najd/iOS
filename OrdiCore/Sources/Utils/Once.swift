//
//  Once.swift
//  
//
//  Created by Ahmed Ramy on 15/02/2022.
//

import Foundation

public class Once {
    private var didRun: Bool = false
    
    public init() { }
    
    public func run(_ action: @escaping VoidCallback) {
        guard didRun == false else { return }
        didRun = true
        action()
    }
}
