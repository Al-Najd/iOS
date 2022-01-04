//
//  TabBarView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/10/2021.
//

import SwiftUI

enum Tab: Identifiable, CaseIterable {
  case home
  case azkar
  case plans
  case rewards
  
  var id: String {
    return "\(self)"
  }
}
