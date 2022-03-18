//
//  SettingsView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 15/02/2022.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import Localization
import Entities
import Pulse
import ReusableUI
import OrdiLogging
import PulseUI

public struct SettingsView: View {
  let store: Store<SettingsState, SettingsAction>
  public init(store: Store<SettingsState, SettingsAction>) {
    self.store = store
  }
  
  public var body: some View {
      NavigationView {
          SettingsForm {
              SettingsSection(title: "Permissions") {
                  SettingsNavigationLink(
                    destination: LocationPermissionView(store: store),
                    title: "Location"
                  )
                  
                  SettingsNavigationLink(
                    destination: NotificationsPermissionView(store: self.store),
                    title: "Notifications"
                  )
              }
              
#if DEBUG
              SettingsSection(title: "Developer Settings") {
                  SettingsNavigationLink(
                    destination: MainView(),
                    title: "Developer Settings"
                  )
              }
#endif
              
              SettingsSection(title: "Support us!  🙌", padContents: false) {
                  ScrollView(.horizontal, showsIndicators: false) {
                      HStack(spacing: 16) {
                          Button(action: {
                              
                          }, label: {
                              SupportUsCard(
                                iconName: "star.fill",
                                text: "Leave us a review",
                                color: Color.primary
                              )
                          })
                          
                          Button(action: { }, label: {
                              SupportUsCard(
                                iconName: "square.and.arrow.up.fill",
                                text: "Share with a friend",
                                color: Color.secondary
                              )
                          })
                          // NB: gives a little bit of space at the end of the scroll view
                          Divider()
                              .hidden()
                      }
                      .padding(.leading)
                  }
              }
          }
          .padding([.leading, .trailing, .top])
          .navigationTitle("Settings")
          .navigationBarTitleDisplayMode(.inline)
      }
  }
}

struct SettingsNavigationLink<Destination>: View where Destination: View {
    let destination: Destination
    let title: LocalizedStringKey
    
    var body: some View {
        SettingsRow {
            NavigationLink(
                destination: self.destination,
                label: {
                    HStack {
                        Text(self.title)
                        Spacer()
                        Image(systemName: "arrow.forward")
                            .font(.system(size: 20))
                    }.foregroundColor(Color.mono.label)
                }
            )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(
      store: .live
    )
  }
}

struct SettingsToggle: View {
  let modifier: ANSettingsModifier
  @Binding var binding: Bool
  let onTap: () -> Void
  
  var body: some View {
    Label {
      Text(modifier.title.localized)
        .scaledFont(.pHeadline, .bold)
        .foregroundColor(.mono.ash)
    } icon: {
      Image(systemName: modifier.icon)
        .scaledFont(.pHeadline, .bold)
        .foregroundColor(.primary.darkMode)
    }
    
    Toggle(
      isOn: $binding,
      label: {
        Text(modifier.subtitles.localized)
          .scaledFont(.pBody)
          .foregroundColor(.mono.label)
      }
    )
      .padding(.p4)
      .padding(.vertical, .p8)
    
    if binding == true {
      Button(action: onTap, label: {
        Text("Go to the iOS Settings Page".localized)
      })
    }
  }
}

struct SettingsPermission: View {
  @State var insufficentReason: String?
  let permission: ANPermission
  let onTap: () -> Void
  
  var body: some View {
    Label {
      Text(permission.title.localized)
        .scaledFont(.pHeadline, .bold)
        .foregroundColor(.mono.ash)
    } icon: {
      Image(systemName: permission.icon)
        .scaledFont(.pHeadline, .bold)
        .foregroundColor(.primary.darkMode)
    }
    
      HStack {
      Text("Status")
        .scaledFont(.pHeadline, .bold)
        .foregroundColor(.mono.ash)
      Spacer()
      
      buildStatusSection(status: permission.status)
          
          if permission.status == .given {
              Text(permission.subtitles.localized)
                  .scaledFont(.pBody)
                  .foregroundColor(.mono.label)
                  .padding(.p8)
              
              Text("What do we use it for?".localized)
                  .scaledFont(.pHeadline, .bold)
                  .foregroundColor(.mono.ash)
              
              ForEach(permission.usages) { usage in
                  Text(usage)
                      .scaledFont(.pBody)
                      .foregroundColor(.mono.label)
              }
          }
    }.padding(.vertical, .p8)
    
    if let insufficentReason = insufficentReason {
      Text(insufficentReason)
        .scaledFont(.pBody, .bold)
        .foregroundColor(.mono.label)
        .padding(.vertical, .p8)
        .fillOnLeading()
    }
    
    Button(action: {
      onTap()
    }) {
      Text("Edit")
    }
  }
  
  @ViewBuilder
  func buildStatusSection(status: ANPermission.Status) -> some View {
    switch status {
      case let .insufficient(reason):
        StatusTagView(status: status)
          .onAppear {
            self.insufficentReason = reason
          }
      default:
        StatusTagView(status: status)
    }
  }
}
  
struct StatusTagView: View {
  let status: ANPermission.Status
  
  private var title: String {
    switch status {
      case .given:
        return "Allowed"
      case .denied:
        return "Denied"
      case .notDetermined:
        return "Not Determined"
      case .insufficient:
        return "Insufficient"
    }
  }
  
  private var titleColor: Color {
    switch status {
      case .given:
        return Color.success.default
      case .denied:
        return Color.danger.default
      case .insufficient:
        return Color.warning.dark
      case .notDetermined:
        return Color.mono.label
    }
  }
  
  public var backgroundColor: Color {
    switch status {
      case .given:
        return Color.success.background
      case .denied:
        return Color.danger.background
      case .insufficient:
        return Color.warning.background
      case .notDetermined:
        return Color.mono.input
    }
  }
  
  var body: some View {
    Text(title)
      .scaledFont(.pBody, .bold)
      .foregroundColor(titleColor)
      .padding(.p8)
      .background(
        backgroundColor
      )
      .overlay(
        RoundedRectangle(cornerRadius: .p8)
          .stroke(
            titleColor,
            lineWidth: 2
          )
      )
  }
}

extension String: Identifiable {
  public var id: String { self }
}

struct SupportUsCard: View {
    let iconName: String
    let text: String
    let color: BrandColor
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .scaledFont(.pLargeTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: .r12)
                        .stroke(lineWidth: .r4)
                ).padding()
            Text(text)
                .scaledFont(.pHeadline, .bold)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: .r12)
                .stroke(lineWidth: .r4)
        )
        .padding()
        .foregroundColor(color.default)
    }
}
