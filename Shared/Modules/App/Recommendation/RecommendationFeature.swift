//
//  RecommendationFeature.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 03/02/2022.
//

import Foundation
import Entities

struct RecommendationsState: Equatable {
  let recommendations: [Recommendation] = []
}

enum RecommendationAction: Equatable {
  case onAppear
  case checkForRecommendations
  case onTap(Recommendation)
}

enum RecommendationEnvironment { }


