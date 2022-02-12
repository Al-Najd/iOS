//
//  Shadows.swift
//  Proba (iOS)
//
//  Proprietary and confidential.
//  Unauthorized copying of this file or any part thereof is strictly prohibited.
//
//  Created by Ahmed Ramy on 23/08/2021.
//  Copyright © 2021 Proba B.V. All rights reserved.
//

import Foundation
import SwiftUI

public protocol Shadowable {
  var largeShadow: ARShadow { get }
  var mediumShadow: ARShadow { get }
  var smallShadow: ARShadow { get }
}
