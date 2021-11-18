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
      AzkarBuffCardView()
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

struct AzkarBuffCardView: View {
  
  @EnvironmentObject var state: PrayersState
  
  var body: some View {
    VStack {
      if state.accumlatedRewards.isEmpty {
        Text("A day full of blessings is awaiting your deeds!".localized)
          .multilineTextAlignment(.center)
          .font(.pLargeTitle)
          .foregroundColor(.mono.offwhite)
          .padding(.bottom, .p8)
      } else {
        Text("Latest Reward".localized)
          .multilineTextAlignment(.center)
          .font(.pHeadline)
          .foregroundColor(.success.light)
        
        Text(state.accumlatedRewards.last?.title ?? .empty)
          .multilineTextAlignment(.center)
          .font(.pLargeTitle)
          .foregroundColor(.mono.offwhite)
          .padding(.bottom, .p8)
        
        if state.accumlatedRewards.count > 2 {
          Text(
            "And var other blessings and Buffs...".localized(arguments: String(state.accumlatedRewards.count - 1))
          )
            .multilineTextAlignment(.center)
            .font(.pBody)
            .foregroundColor(.success.light)
        }
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: .r16)
        .foregroundColor(.secondary1.default)
        .shadow(radius: .r12)
    )
    .padding(.p16)
  }
}

struct RepeatableDeedsList: View {
  var sectionTitle: String
  var deeds: [RepeatableDeed] = []
  
  var allDeedsAreDone: Bool { deeds.first(where: { $0.isDone == false }) == nil }
  
  var body: some View {
    Section(content: {
      if allDeedsAreDone {
        Text("Well Done You Managed to do All the Zekr!".localized(arguments: sectionTitle))
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
            Spacer()
            if deed.isDone {
              Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.success.default)
            } else {
            Text("\(deed.numberOfRepeats)")
              .foregroundColor(.mono.offwhite)
              .font(.pSubheadline)
              .padding(.p16)
              .background(
                Circle()
                  .fill(Color.mono.offblack)
                  .padding(.p4)
                )
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
