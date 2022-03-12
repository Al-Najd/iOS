//
//  SwiftUIView.swift
//  
//
//  Created by Ahmed Ramy on 12/03/2022.
//

import SwiftUI
import ComposableArchitecture


struct NotificationsPermissionView: View {
    
    let store: Store<SettingsState, SettingsAction>
    @ObservedObject var viewStore: ViewStore<SettingsState, SettingsAction>
    
    init(store: Store<SettingsState, SettingsAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        SettingsForm {
            SettingsSection(title: "Notifications") {
                VStack(alignment: .leading, spacing: .p24) {
                    SettingsRow {
                        Toggle(
                            "Enable Notifications",
                            isOn: viewStore.binding(\.$enableNotifications).animation(.easeInOut)
                        ).scaledFont(.pHeadline)
                    }
                    if viewStore.enableNotifications {
                        SettingsRow {
                            VStack(alignment: .leading, spacing: .p16) {
                                Toggle(
                                    "[WIP] Wednesday between Duhr and Aasr Duaa's Reminder",
                                    isOn: .constant(false)
                                )
                                    .scaledFont(.pHeadline)
                                
                                Text("Get notified to do Duaa between Duhr & Aasr")
                                    .foregroundColor(.gray)
                                    .scaledFont(.pFootnote, .bold)
                            }
                        }
                    }
                    
                    if viewStore.enableNotifications {
                        SettingsRow {
                            VStack(alignment: .leading, spacing: .p16) {
                                Toggle(
                                    "[WIP] Duhr Sunnah Reminder",
                                    isOn: .constant(false)
                                ).scaledFont(.pHeadline)
                                
                                Text("Get notified to do Wuduu before Duhr so you can catch the Sunnah")
                                    .foregroundColor(.gray)
                                    .scaledFont(.pFootnote, .bold)
                            }
                        }
                    }
                    
                    if viewStore.enableNotifications {
                        SettingsRow {
                            VStack(alignment: .leading, spacing: .p16) {
                                Toggle(
                                    "[WIP] Fajr Sunnah Reminder",
                                    isOn: .constant(false)
                                ).scaledFont(.pHeadline)
                                
                                Text("Get notified to do Wuduu before Fajr so you can catch the Sunnah")
                                    .foregroundColor(.gray)
                                    .scaledFont(.pFootnote, .bold)
                            }
                        }
                    }
                    
                    if viewStore.enableNotifications {
                        SettingsRow {
                            VStack(alignment: .leading, spacing: .p16) {
                                Toggle(
                                    "[WIP] Catch First line in Masjid's Prayer",
                                    isOn: .constant(false)
                                ).scaledFont(.pHeadline)
                                
                                Text("Get notified to do Wuduu before Prayer so you can catch the first line")
                                    .foregroundColor(.gray)
                                    .scaledFont(.pFootnote, .bold)
                            }
                        }
                    }
                }
            }.padding()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsPermissionView(store: .live)
    }
}
