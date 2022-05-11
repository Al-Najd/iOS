//
//  AzkarView.swift
//  Al Najd
//
//  Created by Ahmed Ramy on 22/01/2022.
//

import SwiftUI
import ReusableUI
import DesignSystem
import Utils
import ComposableArchitecture
import PreviewableView
import Entities

public struct AzkarView: View {
  let store: Store<AzkarState, AzkarAction>
  @State var azkarCategory: AzkarCategory = .sabah
  
  public init(store: Store<AzkarState, AzkarAction>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
        VStack {
            Picker("", selection: $azkarCategory.animation()) {
                ForEach(AzkarCategory.allCases) {
                    Text($0.title.localized)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView {
                if azkarCategory == .sabah {
                    RepeatableDeedsList(
                        sectionTitle: "Azkar Al-Sabah".localized,
                        store: store,
                        deeds: viewStore.azkar[.sabah] ?? []
                    ).padding()
                } else if azkarCategory == .masaa {
                    RepeatableDeedsList(
                        sectionTitle: "Azkar Al-Masaa".localized,
                        store: store,
                        deeds: viewStore.azkar[.masaa] ?? []
                    ).padding()
                }
            }
          
        }
        .onAppear {
            viewStore.send(.onAppear)
        }
        .background(Color.primary.background)
    }
  }
}

struct AzkarView_Previews: PreviewProvider {
    static var previews: some View {
        AzkarView(store: .main)
    }
}

extension Store where State == AzkarState, Action == AzkarAction {
  static let main: Store<AzkarState, AzkarAction> = .init(
    initialState: .init(),
    reducer: azkarReducer,
    environment: .live(.init())
  )
}

struct RepeatableDeedsList: View {
  var sectionTitle: String
  var store: Store<AzkarState, AzkarAction>
  var deeds: [RepeatableDeed]
  
  var allDeedsAreDone: Bool { deeds.filter { $0.isDone == false }.count == 0 }

  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        if allDeedsAreDone {
          buildDoneView()
        } else {
          buildList(viewStore)
        }
      }
    }
  }
}
private extension RepeatableDeedsList {
  @ViewBuilder
  func buildDoneView() -> some View {
    Text("Well Done You Managed to do All the Zekr!".localized(arguments: sectionTitle))
      .padding(.p32)
      .foregroundColor(.mono.offwhite)
      .background(Color.success.default)
      .scaledFont(.displaySmall)
      .cornerRadius(.r16)
  }
  
  @ViewBuilder
  func buildList(_ viewStore: ViewStore<AzkarState, AzkarAction>) -> some View {
    ForEach(deeds) { deed in
      VStack {
        Text(deed.title)
          .scaledFont(
            locale: .arabic,
            .pFootnote,
            .bold
          )
          .multilineTextAlignment(.center)
          .stay(.light)
        
          Text(deed.reward.title)
              .scaledFont(
                locale: .arabic,
                deed.isDone ? .pHeadline : .pSubheadline,
                deed.isDone ? .bold : .regular
              )
              .foregroundColor(
                deed.isDone
                ? .secondary.darkMode
                : .mono.label
              )
              .multilineTextAlignment(.center)
          
        HStack {
          if deed.isDone {
            Image(systemName: "checkmark.seal.fill")
              .foregroundColor(.success.default)
              .scaledFont(.pTitle3, .bold)
          } else {
            Text("\(deed.currentNumberOfRepeats)")
              .foregroundColor(.primary.dark)
              .scaledFont(.pSubheadline)
              .padding(.p8)
              .background(
                Circle()
                  .fill(Color.primary.light)
              )
            
            Text("Repeats are left".localized)
              .scaledFont(.pBody)
              .foregroundColor(.primary.dark)
              .padding(.p8 + .p4)
              .background(
                RoundedRectangle(cornerRadius: .r8)
                  .fill(Color.primary.light)
                  .shadow(radius: 2.5)
              )
          }
        }
      }
      .fillAndCenter()
      .padding()
      .background(
        Color.mono.offwhite
            .cornerRadius(.r12)
            .shadow(radius: .r4)
      )
      .onTapGesture {
        withAnimation {
          viewStore.send(.onDoing(deed))
        }
      }.if(!deed.isDone, transform: { view in
        view.onLongPressGesture(minimumDuration: 1) {
          withAnimation {
            viewStore.send(.onQuickFinish(deed))
          }
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
    }
  }
}
