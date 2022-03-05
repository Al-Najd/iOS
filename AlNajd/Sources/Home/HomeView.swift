//
//  HomeView.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import SwiftUI
import Common
import DesignSystem

struct HomeView: View {
    var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: .p16) {
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
          Text("Prayer")
            .scaledFont(.pTitle1, .bold)
          
          VStack {
            Text("Duhr with be out in 30 Minutes")
              .scaledFont(.pHeadline, .bold)
            
            InsightCardView(
              insight: .init(indicator: .encourage, details: "If you prepare now, you will be able to pray in first line and pray Sunnah and Tahyt Al Masjd")
            )
          }.fillOnLeading()
          
          VStack {
            Text("Azkar")
              .scaledFont(.pTitle2, .bold)
            Text("We have around 20 zekr, how about you do five of them now?")
              .scaledFont(.pHeadline, .bold)
              .multilineTextAlignment(.center)
            
            Button {
              // Route to Azkar's Page
            } label: {
              Text("Let's do them!")
                .scaledFont(.pBody, .bold)
                .foregroundColor(.mono.offwhite)
                .padding()
                .background(RoundedRectangle(cornerRadius: .r12))
            }.fillAndCenter()
          }.fillOnLeading()
          
          Text("Latest Reward")
            .scaledFont(.pTitle1, .bold)
            .fillOnLeading()
          VStack {
            Text("Reward Name")
            Text("Reward Description")
          }.fillAndCenter()
            .padding()
            .background(
              RoundedRectangle(cornerRadius: .r12)
                .foregroundColor(.primary.default)
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
