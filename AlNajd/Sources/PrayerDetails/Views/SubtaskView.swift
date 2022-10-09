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
    var isDone: Bool
    var onDoing: () -> Void
    
    init(_ prayer: ANPrayer, onDoing: @escaping () -> Void) {
        title = prayer.title
        subtitle = prayer.subtitle
        isDone = prayer.isDone
        self.onDoing = onDoing
    }
    
    init(_ sunnah: ANSunnah, onDoing: @escaping () -> Void) {
        title = sunnah.title
        subtitle = sunnah.subtitle
        isDone = sunnah.isDone
        self.onDoing = onDoing
    }
        
    var body: some View {
		HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.leading)
                Text(subtitle)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Button(action: onDoing, label: {
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
            })
        }
        .padding(.horizontal, .p16)
        .padding(.bottom, .p8)
        .onTapGesture(perform: onDoing)
    }
}
