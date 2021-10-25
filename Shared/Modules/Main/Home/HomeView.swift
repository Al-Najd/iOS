//
//  ContentView.swift
//  Shared
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var state: HomeState
  var body: some View {
    ZStack {
      Color("splash")
        .ignoresSafeArea()
      VStack {
        Spacer()
        Image("main_background")
      }.ignoresSafeArea()
      VStack {
        ScrollView {
          BuffCardView()
            .onTapGesture {
              guard app.canShowBuffs else { return }
              state.showBuffs = true
            }
          DeedsList(
            sectionTitle: "Faraaid",
            deeds: state.faraaid
          ).padding()
          
          DeedsList(
            sectionTitle: "Sunnah",
            deeds: state.sunnah
          ).padding()
          
          DeedsList(
            sectionTitle: "Nafila",
            deeds: state.nafila
          ).padding()
          
          Spacer()
        }
      }.ignoresSafeArea(.all, edges: .bottom)
    }.sheet(isPresented: $state.showBuffs, content: { BuffsView() })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(app.state.homeState)
  }
}

struct DeedsList: View {
  var sectionTitle: String
  var deeds: [Deed] = []
  
  var allDeedsAreDone: Bool { deeds.first(where: { $0.isDone == false }) == nil }
  
  var body: some View {
    VStack {
      Text(sectionTitle)
        .font(.pLargeTitle)
        .foregroundColor(.mono.offblack)
      if allDeedsAreDone {
        Text("Well Done! You did All of the \(sectionTitle)s".localized)
          .padding(.p32)
          .foregroundColor(.mono.offwhite)
          .background(Color.success.default)
          .cornerRadius(.r16)
      } else {
        ForEach(deeds) { deed in
          DeedRowView(deed: deed)
            .padding(.vertical, .p32)
        }
      }
    }
  }
}

struct BuffCardView: View {
  
  @EnvironmentObject var state: HomeState
  
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
          Text("And \(state.accumlatedRewards.count - 1) other blessings and Buffs...".localized)
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

struct DeedRowView: View {
  var deed: Deed
  var timerService: TimerService = .init()
  @State var progress: CGFloat = 0
  
  var body: some View {
    GeometryReader { geo in
      ZStack(alignment: .leading) {
        HStack(alignment: .center) {
          if deed.isDone {
            Image(systemName: "checkmark.seal.fill")
              .foregroundColor(.success.default)
          }
          Text(deed.title)
            .font(.pBody)
            .foregroundColor(deed.isDone ? .mono.offwhite : .mono.offblack)
        }
        .padding(.horizontal, .p32)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, .p16)
        .background(deed.isDone ? Color.primary1.default : Color.primary1.background)
        .cornerRadius(.r16)
        .onLongPressGesture(perform: {
          timerService.setTime(in: 1)
          timerService.start(timerTickHandler: { remainingSeconds in
            withAnimation(.linear(duration: 1)) {
              progress = max(1, min(0, CGFloat(3 / remainingSeconds)))
            }
          }, finishHandler: {
            withAnimation(.easeInOut(duration: 0.5)) {
              app.handle(deed: deed)
            }
            MusicService.main.start(effect: .splashEnd)
          })
        })
        .onTapGesture(count: 3, perform: {
          timerService.setTime(in: 0.5)
          timerService.start(timerTickHandler: { remainingSeconds in
            withAnimation(.linear) {
              progress = min(1, CGFloat(remainingSeconds / 1))
            }
          }, finishHandler: {
            app.handle(deed: deed)
            MusicService.main.start(effect: .splashEnd)
          })
        })
        
        if !deed.isDone {
          Rectangle()
            .fill(Color.primary1.default.opacity(0.6))
            .frame(width: min(geo.size.width, geo.size.width * progress), alignment: .center)
            .cornerRadius(.r16)
        }
      }
    }
  }
}
