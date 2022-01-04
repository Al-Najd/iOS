//
//  ContentView.swift
//  Shared
//
//  Created by Ahmed Ramy on 13/10/2021.
//

import SwiftUI

struct PrayersView: View {
  @EnvironmentObject var state: PrayersState
  @EnvironmentObject var dateState: DateState
  
  @State var currentOffset: CGFloat = 0
  @State var lastOffset: CGFloat = 0
  
  var body: some View {
    VStack {
      List {
        DeedsList(
          sectionTitle: "Faraaid".localized,
          deeds: state.faraaid
        ).padding()
        
        DeedsList(
          sectionTitle: "Sunnah".localized,
          deeds: state.sunnah
        ).padding()
        
        DeedsList(
          sectionTitle: "Nafila".localized,
          deeds: state.nafila
        ).padding()
      }
      .simultaneousGesture(DragGesture().onChanged({ value in
        DispatchQueue.main.async {
          let isGoingDown = value.predictedEndTranslation.height < 0
          withAnimation(.easeInOut(duration: 0.3)) {
            dateState.offset = isGoingDown ? -200 : 0
          }
        }
      }))
    }
  }
  
  @ViewBuilder private func buildContentOffsetTracker() -> some View {
    GeometryReader { proxy -> Color in
      let minY = proxy.frame(in: .named("Scrolling")).minY
      let durationOffset: CGFloat = 35
      print("called")
      if minY < currentOffset {
        if currentOffset < 0 && -minY > (lastOffset + durationOffset) {
          
          // HIding tab and updating
          withAnimation(.easeOut.speed (1.5)) {
            dateState.offset = -200
          }
          
          lastOffset = -currentOffset
        }
      }
      
      // Same
      
      if minY > currentOffset && -minY < (lastOffset - durationOffset) {
        
        // Showing tab and updating last offset..
        withAnimation(.easeOut.speed(1.5)) {
          dateState.offset = 0
        }
        
        lastOffset = -currentOffset
        
      }
      
      currentOffset = minY
      
      return Color.clear
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    PrayersView()
      .preferredColorScheme(.dark)
      .environmentObject(app.state.homeState)
      .previewInterfaceOrientation(.portrait)
  }
}

struct DeedsList: View {
  var sectionTitle: String
  var deeds: [Deed] = []
  
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
          }.if(!deed.isDone, transform: { view in
            view.swipeActions(edge: .trailing) {
              Button(
                action: {
                  withAnimation {
                    app.did(deed: deed)
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
                    app.undo(deed: deed)
                  }
                },
                label: { Image(systemName: "delete.backward.fill") }
              ).tint(.danger.default)
            }
          })
        }
      }
    }, header: {
      Text(sectionTitle)
        .font(.pSubheadline)
    })
  }
}

struct BuffCardView: View {
  
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
