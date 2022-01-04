//
//  RewardsView.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 29/12/2021.
//

import SwiftUI

struct RewardsView: View {
  @EnvironmentObject var prayersState: PrayersState
  @EnvironmentObject var azkarState: AzkarState
  var body: some View {
    ZStack {
      Color.mono.offwhite.ignoresSafeArea()
      PagerTabStripView() {
        BuffsView()
          .pagerTabItem {
            TitleNavBarItem(title: "Prayers".localized)
          }
        
        AzkarBuffsView()
          .pagerTabItem {
            TitleNavBarItem(title: "Azkar".localized)
          }
      }.pagerTabStripViewStyle(
        .segmentedControl(backgroundColor: .primary2.dark, padding: .init(top: 0, leading: .p8, bottom: 0, trailing: .p8), placedInToolbar: false)
      )

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
          self.theme.textColor = .mono.offblack
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
