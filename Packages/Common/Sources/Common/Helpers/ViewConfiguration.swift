//
//  ViewConfiguration.swift
//  CAFU
//
//  Created by Ahmed Allam on 13/02/2022.
//  Copyright © 2022. All rights reserved.
//

import Foundation

public protocol ViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func configureViews()
}
