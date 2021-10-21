//
//  ContentView.swift
//  Shared
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var state: AppState
  var body: some View {
    ZStack {
      Color
        .mono
        .background
        .ignoresSafeArea()
      VStack {
        BuffCardView()
          .onTapGesture {
            guard app.canShowBuffs else { return }
            state.showBuffs = true
          }
        List {
          DeedsList(
            sectionTitle: "Faraaid",
            deeds: state.faraaid
          )
          
          DeedsList(
            sectionTitle: "Sunnah",
            deeds: state.sunnah
          )
          
          DeedsList(
            sectionTitle: "Nafila",
            deeds: state.nafila
          )
        }
        
        Spacer()
      }.ignoresSafeArea(.all, edges: .bottom)
    }.sheet(isPresented: $state.showBuffs, content: { BuffsView() })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(app.state)
  }
}

struct DeedsList: View {
  var sectionTitle: String
  var deeds: [Deed] = []
  
  var allDeedsAreDone: Bool { deeds.first(where: { $0.isDone == false }) == nil }
  
  var body: some View {
    Section(sectionTitle) {
      if allDeedsAreDone {
        Text("Well Done! You did All of the \(sectionTitle)s".localized())
          .foregroundColor(.mono.offwhite)
          .listRowBackground(Color.success.default)
      } else {
        ForEach(deeds) { deed in
          HStack {
            Text(deed.title)
            if deed.isDone {
              Spacer()
              Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.success.default)
            }
          }.swipeActions(edge: .trailing) {
            Button(
              action: {
                withAnimation {
                  app.handle(deed: deed)
                }
              },
              label: { Image(systemName: "checkmark.seal") }
            ).tint(.success.default)
          }.swipeActions(edge: .leading) {
            Button(
              action: {
                withAnimation {
                  app.handle(deed: deed)
                }
              },
              label: { Image(systemName: "delete.backward.fill") }
            ).tint(.danger.default)
          }
        }
      }
    }
  }
}

struct BuffCardView: View {

  @EnvironmentObject var state: AppState
  
  var body: some View {
    VStack {
      if state.accumlatedRewards.isEmpty {
        Text("A day full of blessings is awaiting your deeds!".localized())
          .multilineTextAlignment(.center)
          .font(.pLargeTitle)
          .foregroundColor(.mono.offwhite)
          .padding(.bottom, .p8)
      } else {
        Text("Latest Reward".localized())
          .multilineTextAlignment(.center)
          .font(.pHeadline)
          .foregroundColor(.success.light)
        
        Text(state.accumlatedRewards.last?.title ?? .empty)
          .multilineTextAlignment(.center)
          .font(.pLargeTitle)
          .foregroundColor(.mono.offwhite)
          .padding(.bottom, .p8)
      
        if state.accumlatedRewards.count > 2 {
          Text("And \(state.accumlatedRewards.count - 1) other blessings and Buffs...".localized())
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
        .foregroundColor(.primary1.default)
        .shadow(radius: .r12)
    )
    .padding(.p16)
  }
}
