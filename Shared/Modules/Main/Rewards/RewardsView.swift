//
//  RewardsView.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 29/12/2021.
//

import SwiftUI
import PagerTabStripView

struct RewardsView: View {
  @EnvironmentObject var prayersState: PrayersState
  @EnvironmentObject var azkarState: AzkarState
  @State var selection: Int = 0
  var body: some View {
    ZStack {
      Color.mono.offwhite.ignoresSafeArea()
      PagerTabStripView(selection: $selection) {
        BuffsView()
          .pagerTabItem {
            TitleNavBarItem(title: "Prayers")
          }
          .tag(0)
        
        AzkarBuffsView()
          .pagerTabItem {
            TitleNavBarItem(title: "Azkar")
          }
          .tag(1)
      }
    }
  }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
      var state = app.state.homeState
      state.accumlatedRewards = .faraaid
      return RewardsView()
        .preferredColorScheme(.dark)
        .environmentObject(state)
        .environmentObject(app.state.azkarState)
    }
}

struct TitleNavBarItem: View, PagerTabViewDelegate {
    let title: String
    @ObservedObject fileprivate var theme = NavTabViewTheme()

    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(theme.textColor)
                .font(.pSubheadline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func setState(state: PagerTabViewState) {
        switch state {
        case .selected:
          self.theme.textColor = .primary2.dark
          self.theme.backgroundColor = .primary2.background
        case .highlighted:
          self.theme.textColor = .primary2.light
        default:
          self.theme.textColor = .mono.input
          self.theme.backgroundColor = .mono.offwhite
        }
    }
}

fileprivate class NavTabViewTheme: ObservableObject {
  @Published var textColor: Color = .mono.input
  @Published var backgroundColor: Color = .mono.offwhite
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
