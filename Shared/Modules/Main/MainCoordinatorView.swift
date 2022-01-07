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
          .ignoresSafeArea(.all, edges: .bottom)
        
        TabView(selection: $selectedTab) {
          PrayersView()
            .tabItem {
              Image("Prayers")
                .resizable()
                .frame(width: 25, height: 25)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 25))
                .foregroundColor(selectedTab == .home ? .secondary.default : .secondary.dark)
                
              Text("Prayers".localized)
                .font(.pFootnote)
                .foregroundColor(
                  selectedTab == .home ? .secondary.default : .secondary.dark
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
                .foregroundColor(selectedTab == .azkar ? .secondary.default : .secondary.dark)
                
              Text("Azkar".localized)
                .font(.pFootnote)
                .foregroundColor(
                  selectedTab == .azkar ? .secondary.default : .secondary.dark
                )
            }.tag(Tab.azkar)
          
          RewardsView()
            .tabItem {
              Image("Rewards")
                .resizable()
                .frame(width: 25, height: 25)
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 25))
                .foregroundColor(selectedTab == .rewards ? .secondary.default : .secondary.dark)
                
              Text("Rewards".localized)
                .font(.pFootnote)
                .foregroundColor(selectedTab == .rewards ? .secondary.default : .secondary.dark)
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
                  .padding(.horizontal, .p16)
                  .padding(.vertical, .p8)
                  .cornerRadius(16)
                  .overlay(
                    RoundedRectangle(cornerRadius: .p8)
                      .stroke(Color.mono.line, lineWidth: 2.5)
                  )
                  .padding(.bottom, .p4)
                  .onTapGesture {
                    dateState.showDaySelection = true
                  }
                  .fixedSize(horizontal: true, vertical: false)
              }
            }
        
        ToolbarItem(placement: .navigationBarLeading) {
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
    let prayersState = PrayersState()
    prayersState.faraaid = prayersState.faraaid.map {
      var temp = $0
      temp.isDone = true
      return temp
    }
    return MainCoordinatorView()
      .environmentObject(app.state)
      .environmentObject(prayersState)
      .environmentObject(AzkarState())
      .environmentObject(app.state.plansState)
      .environmentObject(app.state.rewardsState)
      .environmentObject(app.state.dateState)
      .environmentObject(app.state.settingsState)
  }
}
