//
//  OTabBarView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import SwiftUI
import DesignSystem
import Utils
import ReusableUI
import PreviewableView
import ComposableArchitecture

struct OTabBarView: View {
  @Binding var tab: Tab
  
  var body: some View {
    HStack(spacing: 0) {
      ForEach(Tab.allCases.sorted(by: { $0.rawValue < $1.rawValue })) { tab in
        Button {
          withAnimation {
            self.tab = tab
          }
        } label: {
          VStack {
            Image(
              systemName: tab == self.tab ? tab.activeIcon : tab.icon
            )
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(
                width: CGFloat(22.0).adaptRatio(),
                height: CGFloat(22.0).adaptRatio()
              )
            if tab == self.tab {
              Text(tab.title)
                .font(
                  tab == self.tab
                  ? .pFootnote.bold()
                  : .pFootnote
                )
            }
          }
          .frame(maxWidth: .infinity)
          .foregroundColor(
            self.tab == tab
            ? .primary.light
            : .mono.input.opacity(0.5)
          )
          .environment(\.colorScheme, .light)
        }
      }
    }
    .padding([.horizontal, .top])
    .padding(.bottom, .p8.adaptRatio())
    .background(
      Color
        .primary
        .dark
        .cornerRadius(.r16, corners: [.topLeft, .topRight])
        .ignoresSafeArea()
        .environment(\.colorScheme, .light)
    )
    .shadow(radius: 4.adaptRatio(), x: 0, y: -4.adaptRatio())
    .background(
      Color
        .primary
        .background
    )
    
  }
}

struct OTabBarView_Previews: PreviewProvider {
    static var previews: some View {
      PreviewableView([.darkMode]) {
        VStack {
          Spacer()
          OTabBarView(tab: .constant(.prayer))
        }
      }
    }
}
