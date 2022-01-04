//
//  HomeCoordinator.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//
import PulseUI
import SwiftUI
import PartialSheet

final class PrayersState: ObservableObject {
  @Published var sunnah: [Deed] = .sunnah
  @Published var faraaid: [Deed] = .faraaid
  @Published var nafila: [Deed] = .nafila
  
  @Published var accumlatedRewards: [Deed] = []
  @Published var showBuffs: Bool = false
}

struct MainCoordinatorView: View {
  @EnvironmentObject var state: AppState
  @EnvironmentObject var dateState: DateState
  @State var selectedTab: Tab = .home
  var body: some View {
    ZStack {
      Color("splash")
        .ignoresSafeArea(.all, edges: .vertical)
      
      TabView(selection: $selectedTab) {
        PrayersView()
          .tabItem {
            Text("Prayers".localized)
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .home ? .secondary1.default : .secondary3.dark
              )
          }.tag(Tab.home)
        
        AzkarView()
          .tabItem {
            Text("Azkar".localized)
              .font(.pFootnote)
              .foregroundColor(
                selectedTab == .azkar ? .secondary1.default : .secondary3.dark
              )
          }.tag(Tab.azkar)
        
//        PlansView()
//          .tabItem {
//            Text("Plans".localized)
//              .font(.pFootnote)
//              .foregroundColor(
//                selectedTab == .plans ? .secondary1.default : .secondary3.dark
//              )
//          }.tag(Tab.plans)
        
        RewardsView()
          .tabItem {
            Text("Rewards".localized)
              .font(.pFootnote)
              .foregroundColor(selectedTab == .rewards ? .secondary1.default : .secondary3.dark)
          }.tag(Tab.rewards)
      }.sheet(isPresented: $dateState.showDaySelection) {
        VStack {
          DatePicker("Day you want to review", selection: $dateState.selectedDate.animation(.easeInOut), in: ...Date.now, displayedComponents: .date)
            .datePickerStyle(.graphical)
          
          Text("Hint: Choosing a Date allows you to revisit your achievements at that date!".localized)
            .font(.pFootnote)
            .foregroundColor(.mono.body)
          
          Spacer()
          
        }.padding()
      }
      
      VStack {
        Text(dateState.title)
          .foregroundColor(.mono.offblack)
          .padding(.vertical, .p8)
          .padding(.horizontal, .p32)
          .background(Color.mono.background)
          .cornerRadius(.p16)
          .onTapGesture {
            dateState.showDaySelection = true
          }
          .offset(y: dateState.offset)
        
        Spacer()
      }
    }
  }
  
  private func turnDateToHumanReadable(_ date: Date) -> String {
    return date.isInToday ? "Today".localized : "\(turnToOrdinal(date.day)), \(date.monthName(ofStyle: .threeLetters))"
  }
  
  private func turnToOrdinal(_ day: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter.string(from: NSNumber(value: day)) ?? "\(day)"
  }
}

struct MainCoordinatorView_Previews: PreviewProvider {
  static var previews: some View {
    MainCoordinatorView()
      .environmentObject(app.state.homeState)
  }
}
