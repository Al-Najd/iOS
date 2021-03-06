//
//  RewardsView.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import SwiftUI
import ReusableUI
import DesignSystem
import Utils
import ComposableArchitecture
import PreviewableView
import Entities
import Localization
import Date

public struct RewardsView: View {
  let store: Store<RewardsState, RewardsAction>
  
  public init(store: Store<RewardsState, RewardsAction>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView(.vertical, showsIndicators: false) {
        buildPrayersSection(viewStore)
        buildAzkarSection(viewStore)
      }.onAppear {
        viewStore.send(.onAppear)
      }.background(Color.primary.background)
    }
  }
}

private extension RewardsView {
  
  
  @ViewBuilder
  func buildPrayersSection(_ viewStore: ViewStore<RewardsState, RewardsAction>) -> some View {
    VStack {
      VStack(alignment: .leading) {
        Text("Prayers".localized)
          .scaledFont(.pLargeTitle, .bold)
          .foregroundColor(.mono.offblack)
      }
      .fillOnLeading()
      .padding()
      ForEach(DeedCategory.allCases) { category in
        if let prayers = viewStore.prayers[category] ?? [], !prayers.isEmpty {
          PrayerRewardsList(
            category: category,
            prayers: prayers
          )
        } else {
          LockedRewardView(
            title: "\("Prayers".localized) \(category.title.localized)"
          )
        }
      }
    }
  }
  
  @ViewBuilder
  func buildAzkarSection(_ viewStore: ViewStore<RewardsState, RewardsAction>) -> some View {
      VStack {
          VStack(alignment: .leading) {
              Text("Azkar".localized)
                  .scaledFont(.pLargeTitle, .bold)
                  .foregroundColor(.mono.offblack)
          }
          .fillOnLeading()
          .padding()
          ForEach(AzkarCategory.allCases) { category in
              if let azkar = viewStore.azkar[category] ?? [], !azkar.isEmpty {
                  AzkarRewardsList(category: category, azkar: azkar)
              } else {
                  LockedRewardView(
                    title: "\("Azkar".localized) \(category.title.localized)"
                  )
              }
          }
      }
  }
}

struct PrayerRewardsList: View {
  let category: DeedCategory
  let prayers: [Deed]
  var body: some View {
    VStack {
      Text(category.title.localized)
        .scaledFont(.pTitle2, .bold)
        .foregroundColor(.mono.offblack)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(prayers) { deed in
            DeedRewardCard(deed: deed)
          }
        }.padding()
      }
    }
  }
}

struct DeedRewardCard: View {
  let deed: Deed
  var body: some View {
    VStack(spacing: .p4.adaptV(min: .p4)) {
      if deed.reward.title.isEmpty == false {
        Text(deed.title.localized)
          .scaledFont(.pFootnote, .bold)
          .multilineTextAlignment(.center)
        Text(deed.reward.title.localized)
          .scaledFont(.pTitle3, .bold)
          .foregroundColor(.secondary.dark)
          .multilineTextAlignment(.center)
      } else {
        Text(deed.title.localized)
          .scaledFont(.pTitle2, .bold)
          .multilineTextAlignment(.center)
      }
    }
    .frame(maxHeight: .infinity)
    .fillAndCenter()
    .padding(.p16)
    .background(
      RoundedRectangle(cornerRadius: .r16)
        .fill(Color.secondary.background)
        .shadow(radius: .r4)
    )
    .frame(width: getScreenSize().width - .p16)
  }
}

struct RepeatableDeedRewardCard: View {
  let deed: RepeatableDeed
  var body: some View {
    VStack(spacing: .p4.adaptV(min: .p4)) {
      if deed.reward.title.isEmpty == false {
        Text(deed.title)
          .scaledFont(locale: .arabic, .pHeadline, .bold)
          .multilineTextAlignment(.center)
        Text(deed.reward.title)
          .scaledFont(locale: .arabic, .pTitle3, .bold)
          .foregroundColor(.secondary.dark)
          .multilineTextAlignment(.center)
      } else {
        Text(deed.title)
          .scaledFont(.pTitle2, .bold)
          .multilineTextAlignment(.center)
      }
    }
    .frame(maxHeight: .infinity)
    .fillAndCenter()
    .padding(.p16)
    .background(
      RoundedRectangle(cornerRadius: .r16)
        .fill(Color.secondary.background)
        .shadow(radius: .r4)
    )
    .frame(width: getScreenSize().width - .p16)
  }
}

struct AzkarRewardsList: View {
  let category: AzkarCategory
  let azkar: [RepeatableDeed]
  var body: some View {
    VStack {
      Text(category.title.localized)
        .scaledFont(.pTitle2, .bold)
        .foregroundColor(.mono.offblack)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(azkar) { deed in
            RepeatableDeedRewardCard(deed: deed)
          }
        }.padding()
      }
    }
  }
}

struct RewardsView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewableView([
      .darkMode
    ]) {
      RewardsView(
        store: .init(
          initialState: .init(),
          reducer: rewardsReducer,
          environment: .live(RewardsEnvironment.init())
        )
      )
    }
  }
}

extension UIRectCorner {
  public static let topLeading: UIRectCorner = {
    Locale.current.isRTL ? .topRight : .topLeft
  }()
  
  public static var topTrailing: UIRectCorner = {
    !Locale.current.isRTL ? .topRight : .topLeft
  }()
  
  public static var bottomLeading: UIRectCorner = {
    Locale.current.isRTL ? .bottomRight : .bottomLeft
  }()
  
  public static var bottomTrailing: UIRectCorner = {
    !Locale.current.isRTL ? .bottomRight : .bottomLeft
  }()
}

extension Locale {
  var isRTL: Bool {
    guard let language = Locale.preferredLanguages.first else { return false }
    let direction = Locale.characterDirection(forLanguage: language)
    switch direction {
        case .rightToLeft:
      return true
    default:
      return false
    }
  }
}

struct LockedRewardView: View {
  
  let title: String
  
  var body: some View {
    VStack(spacing: .p24) {
      Image(systemName: "lock")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: .p24, height: .p24)
      
      Text("Locked".localized(arguments: title.localized))
        .scaledFont(.pBody, .bold)
    }
    .stay(.light)
    .frame(width: getScreenSize().width - .p16, height: CGFloat(200.0).adaptRatio())
    .background(Color.mono.line)
    .cornerRadius(.r16)
    .padding(.p16)
    .shadow(radius: .r4, y: .p4)
  }
}
