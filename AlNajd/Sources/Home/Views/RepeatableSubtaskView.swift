//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 14/08/2022.
//

import SwiftUI
import Entities

struct RepeatableSubtaskView: View {
    var title: String
    var subtitle: String
    var repetation: Int
    var isDone: Bool { repetation == .zero }
        
    init(_ zekr: ANAzkar) {
        title = zekr.name
        subtitle = zekr.reward
        repetation = zekr.repetation
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
                Group {
                    if isDone {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .foregroundColor(
                                .success.darkMode
                            )
                    } else if repetation == 1 {
                        Image(systemName: "square")
                            .resizable()
                            .foregroundColor(.mono.offwhite)
                            .frame(width: .p24, height: .p24)
                            .padding()
                    } else {
                        Text(repetation.formatted())
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote, .bold)
                            .multilineTextAlignment(.center)
                    }
                }
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
