//
//  HomeView.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import SwiftUI
import Common

struct HomeView: View {
    var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
        Group {
        HStack {
          VStack(alignment: .leading) {
            Text("28 Rajab, 1443 AH")
            Text("Tuesday, 01 March, 2022")
          }
          
          Spacer()
          Image(systemName: "bell")
        }.scaledFont(.displaySmall)
        
        InsightCardView(
          insight: .init(
            indicator: .tipOfTheDay,
            details: "Don't get distracted by Dunia, it's temporarily, and never forget why you're here, you're here to build yourself a place in Jannah"
          )
        )
          
          
        }.padding(.horizontal)
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
