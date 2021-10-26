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
      }.ignoresSafeArea(.all, edges: .vertical)
      .sheet(isPresented: $state.showBuffs, content: { BuffsView() })
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
  @State var progress: CGFloat = 0
  @State var isPressing: Bool = false
  @State var duration: CGFloat = 2
  
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
        .background(
          RoundedRectangle(cornerRadius: .r16)
            .fill(Color.primary1.default.opacity(deed.isDone ? 0.3 : 1))
            .frame(
              width: (geo.size.width * progress).clamped(to: 0...geo.size.width),
              alignment: .leading
            )
        )
        .background(deed.isDone ? Color.primary1.default.opacity(0.75) : Color.primary1.background)
        .cornerRadius(.r16)
        .onLongPressGesture(minimumDuration: duration) { isPressing in
          if isPressing {
            withAnimation(.linear(duration: duration)) {
              progress = deed.isDone ? 0 : 1
            }
            HapticService.main.generateHoldFeedback(for: duration)
          } else {
            withAnimation(.linear(duration: duration/2)) {
              progress = deed.isDone ? 1 : 0
            }
            HapticService.main.generateHoldFeedback(for: duration/2)
          }
        } perform: {
          progress = deed.isDone ? 0 : 1
          HapticService.main.generate(feedback: .success)
          withAnimation(.easeInOut) {
            app.handle(deed: deed)
            MusicService.main.start(effect: .splashEnd)
          }
        }
      }
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
