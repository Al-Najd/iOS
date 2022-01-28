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

struct AzkarView: View {
  let store: Store<AzkarState, AzkarAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView {
        RepeatableDeedsList(
          sectionTitle: "Azkar Al-Sabah".localized,
          store: store,
          deeds: viewStore.azkar[.sabah] ?? []
        ).padding()
        
        RepeatableDeedsList(
          sectionTitle: "Azkar Al-Masaa".localized,
          store: store,
          deeds: viewStore.azkar[.masaa] ?? []
        ).padding()
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
}

struct AzkarView_Previews: PreviewProvider {
    static var previews: some View {
      PreviewableView([
        .noNotch,
        .darkMode,
        .iPad
      ]) {
        AzkarView(store: .main)
      }
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
        Text(sectionTitle)
          .font(.pLargeTitle)
          .fillOnLeading()
        
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
      .font(.displaySmall)
      .cornerRadius(.r16)
  }
  
  @ViewBuilder
  func buildList(_ viewStore: ViewStore<AzkarState, AzkarAction>) -> some View {
    ForEach(deeds) { deed in
      VStack {
        Text(deed.title)
          .font(
            FontManager.shared.getFont(locale: .arabic, type: .sansSerif, category: .text, scale: .xsmall, weight: .bold).toSwiftUIFont()
          )
          .multilineTextAlignment(.center)
          .stay(.light)
        
        HStack {
          if deed.isDone {
            Image(systemName: "checkmark.seal.fill")
              .foregroundColor(.success.default)
          } else {
            Text("\(deed.currentNumberOfRepeats)")
              .foregroundColor(.secondary.dark)
              .font(.pSubheadline)
              .padding(.p8)
              .background(
                Circle()
                  .fill(Color.secondary.background)
              )
          }
          
          Text("Repeats are left".localized)
            .font(.pBody)
            .foregroundColor(.secondary.dark)
            .padding(.p8 + .p4)
            .background(
              RoundedRectangle(cornerRadius: .r8)
                .fill(Color.secondary.light)
                .shadow(radius: 2.5)
            )
        }
      }
      .fillAndCenter()
      .padding()
      .background(
        RoundedRectangle(cornerRadius: .r16)
          .fill(Color.primary.default)
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
