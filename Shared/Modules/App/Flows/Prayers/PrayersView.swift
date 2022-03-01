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

struct PrayersView: View {
  let store: Store<PrayerState, PrayerAction>
  
  @State var showTip: Bool = true
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      List {
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
      .onAppear {
        viewStore.send(.onAppear)
        
        withAnimation(.easeInOut.delay(1)) {
          showTip = true
        }
      }
      .padding(.top, .p4)
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
    initialState: .init(dateState: .init()),
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
      Section(content: {
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
            HStack {
              Text(deed.title.localized)
                .scaledFont(.pHeadline, .bold)
                .foregroundColor(.primary.background)
              if deed.isDone {
                Spacer()
                Image(systemName: "checkmark.seal.fill")
                  .foregroundColor(.success.default)
                  .padding(.p4)
                  .background(
                    Rectangle()
                      .fill(Color.mono.offwhite)
                      .frame(maxHeight: .infinity)
                      .cornerRadius(.r8)
                  )
              }
            }
            .if(!deed.isDone, transform: { view in
              view.swipeActions(edge: .trailing) {
                Button(
                  action: {
                    withAnimation {
                      viewStore.send(.onDoing(deed))
                    }
                  },
                  label: { Image(systemName: "checkmark.seal") }
                ).tint(.success.default)
              }
            }).if(deed.isDone, transform: { view in
              view.swipeActions(edge: .leading) {
                Button(
                  action: {
                    withAnimation {
                      viewStore.send(.onUndoing(deed))
                    }
                  },
                  label: { Image(systemName: "delete.backward.fill") }
                ).tint(.danger.default)
              }
            })
          }.listRowBackground(
            Color
              .primary
              .default.ignoresSafeArea()
          )
        }
      }, header: {
        Text(sectionTitle)
          .foregroundColor(Color.primary.darkMode)
          .scaledFont(.pLargeTitle, .bold)
          .fillOnLeading()
          .padding(.bottom, .p8)
      })
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
