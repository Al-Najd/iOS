//
//  TabBarView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/10/2021.
//

import SwiftUI

enum Tab: Identifiable, CaseIterable {
  case home
  case settings
  
  var id: String {
    return self.image
  }
  
  var image: String {
    switch self {
    case .home:
      return "icn_tabBar_home"
    case .settings:
      return "icn_tabBar_settings"
    }
  }
  
  var activeColor: Color {
    switch self {
    case .home:
      return .secondary1.background
    case .settings:
      return .secondary2.background
    }
  }
}

struct TabBarView: View {
  // Location for each Curve
  @State var xAxis: CGFloat = 0
  @Binding var selectedTab: Tab
  @Namespace var animation

  var body: some View {
    HStack(spacing: 0) {
      ForEach(Tab.allCases) { (currentTab: Tab) in
        Spacer()
          
        GeometryReader { reader in
          Button(action: {
            withAnimation(.spring()) {
              selectedTab = currentTab
              xAxis = reader.frame(in: .global).minX
            }
          }, label: {
            Image(currentTab.image)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 25, height: 25)
              .padding(selectedTab == currentTab ? 15 : 0)
              .background(
                currentTab.activeColor.opacity(
                  selectedTab == currentTab ? 1 : 0
                ).clipShape(
                  Circle()
                )
              )
              .matchedGeometryEffect(
                id: currentTab,
                in: animation
              )
              .offset(
                x: selectedTab == currentTab
                ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX)
                : 0,
                y: selectedTab == currentTab ? -50 : 0
              )
          })
            .onAppear {
              if currentTab == Tab.allCases.first ?? .settings {
                xAxis = reader.frame(in: .global).minX
              }
            }
        }
        .frame(width: 25, height: 30)
        
        Spacer()
          .frame(maxWidth: 100)
      }
    }
    .padding(.horizontal, 30)
    .padding(.vertical)
    .background(
      Color.mono.offwhite.opacity(0.6).clipShape(
        CustomShape(
          xAxis: xAxis
        )
      ).cornerRadius(12)
    )
    .padding(.horizontal)
    // Bottom Edge
    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
  }
}

struct CustomShape: Shape {
    
    var xAxis: CGFloat
    
    var animatableData: CGFloat {
        get {
            return xAxis
        }
        
        set {
            xAxis = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
