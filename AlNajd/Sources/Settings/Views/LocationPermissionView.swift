//
//  SwiftUIView.swift
//  
//
//  Created by Ahmed Ramy on 12/03/2022.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct LocationPermissionView: View {
    
    let store: Store<SettingsState, SettingsAction>
    @ObservedObject var viewStore: ViewStore<SettingsState, SettingsAction>
    
    init(store: Store<SettingsState, SettingsAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        SettingsForm {
            VStack(alignment: .leading, spacing: .p24) {
                SettingsPermission(
                    permission: viewStore.locationPermission, onTap: {
                        viewStore.send(.onTapPermission(viewStore.locationPermission))
                    })
                
                if viewStore.locationPermission.status == .given {
                    SettingsRow {
                        VStack(alignment: .leading, spacing: .p16) {
                            Toggle(
                                "[WIP] Use location in calculating best time to catch Sunnah and First line in Gama'a",
                                isOn: .constant(false)
                            )
                                .scaledFont(.pHeadline)
                            
                            Text("Helps in sending notifications more accurately")
                                .foregroundColor(.gray)
                                .scaledFont(.pFootnote, .bold)
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Location")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermissionView(store: .live)
    }
}
