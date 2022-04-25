//
//  PrayersView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 21/01/2022.
//

import SwiftUI
import ComposableArchitecture
import ReusableUI
import DesignSystem
import Utils
import PreviewableView
import Entities
import Date

public struct PrayersView: View {
  let store: Store<PrayerState, PrayerAction>
  
  public init(store: Store<PrayerState, PrayerAction>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                DeedsList(
                    sectionTitle: "Faraaid".localized,
                    deeds: viewStore.prayers.faraaid?.deeds ?? [],
                    store: store
                )
                
                DeedsList(
                    sectionTitle: "Sunnah".localized,
                    deeds: viewStore.prayers.sunnah?.deeds ?? [],
                    store: store
                )
                
                DeedsList(
                    sectionTitle: "Nafila".localized,
                    deeds: viewStore.prayers.nafila?.deeds ?? [],
                    store: store
                )
            }
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
        .padding(.top, .p4)
        .background(Color.primary.background.ignoresSafeArea())
    }
  }
}

struct PrayersView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewableView(
      [
        .darkMode,
        .noNotch,
        .iPad
      ]
    ) {
      PrayersView(
        store: .main
      )
    }
  }
}

extension Store where State == PrayerState, Action == PrayerAction {
  static let main: Store<PrayerState, PrayerAction> = .init(
    initialState: .init(),
    reducer: prayerReducer,
    environment: .live(PrayerEnvironment())
  )
}

struct DeedsList: View {
  
  var sectionTitle: String
  var deeds: [Deed] = []
  let store: Store<PrayerState, PrayerAction>
  var allDeedsAreDone: Bool { deeds.filter { $0.isDone == false }.count == 0 }
  
  var body: some View {
    WithViewStore(store) { viewStore in
        VStack {
            Text(sectionTitle)
                .foregroundColor(Color.primary.darkMode)
                .scaledFont(.pLargeTitle, .bold)
                .fillOnLeading()
                .padding(.bottom, .p8)
            
            if allDeedsAreDone {
                Text("Well Done".localized(arguments: sectionTitle))
                    .scaledFont(.pTitle3, .bold)
                    .padding(.p48)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.mono.offwhite)
                    .background(Color.success.default)
                    .cornerRadius(.r16)
            } else {
                ForEach(deeds) { deed in
                    VStack(alignment: .leading, spacing: .p16) {
                        HStack {
                            Image(
                                systemName: deed.isDone
                                ? "checkmark.circle"
                                : "circle"
                            )
                                .scaledFont(.pHeadline, .bold)
                                .foregroundColor(
                                    deed.isDone
                                    ? .success.default
                                    : .mono.offblack
                                )
                            Text(deed.title.localized)
                                .scaledFont(.pHeadline, .bold)
                                .foregroundColor(
                                    deed.isDone
                                    ? .success.default
                                    : .mono.offblack
                                )
                        }.fillOnLeading()
                        Text(deed.reward.title)
                            .scaledFont(
                                deed.isDone
                                ? .pHeadline
                                : .pSubheadline,
                                deed.isDone
                                ? .bold
                                : .regular
                            )
                            .foregroundColor(
                                deed.isDone
                                ? .secondary.darkMode
                                : .mono.label
                            )
                    }
                    .padding()
                    .background(
                        Color.mono.offwhite
                            .cornerRadius(.r12)
                            .shadow(radius: .r4)
                    )
                    .onTapGesture {
                        withAnimation {
                            viewStore.send(
                                deed.isDone
                                ? .onUndoing(deed)
                                : .onDoing(deed)
                            )
                        }
                    }
                }
            }
        }.padding()
    }
  }
}

extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}

#if swift(<5.1)
extension Strideable where Stride: SignedInteger {
  func clamped(to limits: CountableClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}
#endif

extension Animation {
  func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
    if expression {
      return self.repeatForever(autoreverses: autoreverses)
    } else {
      return self
    }
  }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero
  
  static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
