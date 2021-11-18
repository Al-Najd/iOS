//
//  AzkarView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 17/11/2021.
//

import SwiftUI

final class AzkarState: ObservableObject {
  @Published var sabah: [RepeatableDeed] = .sabah
  @Published var masaa: [RepeatableDeed] = .masaa
  
  @Published var accumlatedRewards: [RepeatableDeed] = []
  @Published var showBuffs: Bool = false
}

struct AzkarBuffsView: View {
  @EnvironmentObject var state: AzkarState
  
  var body: some View {
    ZStack {
      Color.primary2.default.ignoresSafeArea()
      ScrollView {
        VStack {
          ForEach(state.accumlatedRewards) { deed in
            VStack {
              Text(deed.title)
                .multilineTextAlignment(.center)
                .font(.pTitle2)
                .foregroundColor(.mono.ash)
                .padding(.bottom, .p4)
              Text( deed.reward.title)
                .multilineTextAlignment(.center)
                .font(.pTitle3)
                .foregroundColor(.success.dark)
            }
            .frame(
              maxWidth: .infinity,
              alignment: .center
            )
            .padding()
            .background(
              RoundedRectangle(
                cornerRadius: .r16
              )
                .foregroundColor(.primary2.dark)
            )
            .padding()
          }
        }
        
        Spacer()
      }.padding(.top)
    }
  }
}

struct AzkarView: View {
  
  @EnvironmentObject var state: AzkarState
  
  var body: some View {
    VStack {
      BuffCardView()
        .onTapGesture {
          guard app.canShowBuffs else { return }
          state.showBuffs = true
        }
      List {
        RepeatableDeedsList(
          sectionTitle: "Azkar Al-Sabah".localized,
          deeds: state.sabah
        ).padding()
        
        RepeatableDeedsList(
          sectionTitle: "Azkar Al-Masaa".localized,
          deeds: state.masaa
        ).padding()
      }
    }
    .sheet(isPresented: $state.showBuffs, content: { AzkarBuffsView() })
  }
}

struct RepeatableDeedsList: View {
  var sectionTitle: String
  var deeds: [RepeatableDeed] = []
  
  var allDeedsAreDone: Bool { deeds.first(where: { $0.isDone == false }) == nil }
  
  var body: some View {
    Section(content: {
      if allDeedsAreDone {
        Text("Well Done".localized(arguments: sectionTitle))
          .padding(.p32)
          .foregroundColor(.mono.offwhite)
          .background(Color.success.default)
          .font(.displaySmall)
          .cornerRadius(.r16)
      } else {
        ForEach(deeds) { deed in
          HStack {
            Text(deed.title)
              .font(.pBody)
            if deed.isDone {
              Spacer()
              Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.success.default)
            }
          }.onTapGesture {
            app.did(deed: deed)
          }
        }
      }
    }, header: {
      Text(sectionTitle)
        .font(.pSubheadline)
    })
  }
}

struct AzkarView_Previews: PreviewProvider {
  static var previews: some View {
    AzkarView()
  }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
