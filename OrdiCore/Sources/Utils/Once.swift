//
//  Once.swift
//  
//
//  Created by Ahmed Ramy on 15/02/2022.
//

import Foundation

public class Once {
    var didRun: Bool = false
    
    func run(_ action: @escaping VoidCallback) {
        guard didRun == false else { return }
        didRun = true
        action()
    }
}
