//
//  HomeCoordinator.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 24/10/2021.
//
import PulseUI
import SwiftUI

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
  @EnvironmentObject var settingsState: SettingsState
  @State var selectedTab: Tab = .home
  var body: some View {
    NavigationView {
      ZStack {
        Color("splash")
          .ignoresSafeArea(.all, edges: .vertical)
        
        TabView(selection: $selectedTab) {
          PrayersView()
            .tabItem {
              Image("Prayers")
                .resizable()
                .frame(width: 25, height: 25)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 25))
                .foregroundColor(selectedTab == .home ? .secondary1.default : .secondary3.dark)
                
              Text("Prayers".localized)
                .font(.pFootnote)
                .foregroundColor(
                  selectedTab == .home ? .secondary1.default : .secondary3.dark
                )
            }.tag(Tab.home)
          AzkarView()
            .tabItem {
              Image("Azkar")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 25))
                .foregroundColor(selectedTab == .azkar ? .secondary1.default : .secondary3.dark)
                
              Text("Azkar".localized)
                .font(.pFootnote)
                .foregroundColor(
                  selectedTab == .azkar ? .secondary1.default : .secondary3.dark
                )
            }.tag(Tab.azkar)
          
          RewardsView()
            .tabItem {
              Image("Rewards")
                .resizable()
                .frame(width: 25, height: 25)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 25))
                .foregroundColor(selectedTab == .rewards ? .secondary1.default : .secondary3.dark)
                
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
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
            ToolbarItem(placement: .principal) {
              HStack {
                Text(dateState.title)
                  .foregroundColor(.mono.offblack)
                  .padding(.vertical, .p8)
                  .padding(.leading, .p32)
                  .onTapGesture {
                    dateState.showDaySelection = true
                  }
                Image(systemName: "chevron.down.square.fill")
                  .padding(.trailing, .p32)
              }
            }
        
        ToolbarItem(placement: LocalizationService.isRTL() ? .navigationBarLeading : .navigationBarTrailing) {
          Button(
            action: {
              settingsState.showSettings = true
            }, label: {
              Image(systemName: "gear")
                .font(.pBody.bold())
                .foregroundColor(.mono.offblack)
            }
          )
        }
      }
      .sheet(isPresented: $settingsState.showSettings, content: { SettingsView() })
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
      .environmentObject(app.state.dateState)
  }
}
