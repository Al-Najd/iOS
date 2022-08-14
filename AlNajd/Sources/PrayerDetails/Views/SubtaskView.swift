//
//  SubtaskView.swift
//  
//
//  Created by Ahmed Ramy on 14/08/2022.
//

import SwiftUI
import Entities

struct SubtaskView: View {
    var title: String
    var subtitle: String
    var isDone: Bool = false
    
    init(_ prayer: ANPrayer) {
        title = prayer.title
        subtitle = prayer.subtitle
    }
    
    init(_ sunnah: ANSunnah) {
        title = sunnah.title
        subtitle = sunnah.subtitle
    }
        
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.center)
                Text(subtitle)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button {
                // TODO: - Send done action
            } label: {
                Image(systemName: isDone ? "checkmark.square.fill" : "square")
                    .resizable()
                    .foregroundColor(
                        isDone
                        ? .success.darkMode
                        : .mono.offwhite
                    )
                    .frame(width: .p24, height: .p24)
                    .padding()
                    .background(
                        Circle()
                            .foregroundColor(
                                isDone
                                ? .success.light.opacity(0.25)
                                : .mono.offwhite.opacity(0.1)
                            )
                    )
            }

        }
        .padding(.horizontal, .p16)
        .padding(.bottom, .p8)
    }
}
