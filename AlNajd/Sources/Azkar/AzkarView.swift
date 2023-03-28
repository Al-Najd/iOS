//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 26/03/2023.
//

import SwiftUI
import Utils
import Common
import DesignSystem
import ReusableUI
import Inject
import Entity

public struct AzkarView: View {
    @ObserveInjection var inject
    public init() { }

    public var body: some View {
        VStack {
            ZekrView(title: "Something Title", subtitle: "Something Subtitle", repetation: 1) {
                
            }.padding()
        }
        .fill()
        .background(
            Color.mono.background
                .ignoresSafeArea()
        )
        .enableInjection()
    }
}


struct ZekrView: View {
    var title: String
    var subtitle: String
    var repetation: Int
    var isDone: Bool { repetation == .zero }
    var onDoing: () -> Void

    var body: some View {
        VStack {
            HStack(spacing: .p16) {
                Text(title)
                    .foregroundColor(.mono.offblack)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.leading)

                Spacer()

                Button(action: onDoing, label: {
                    Group {
                        if isDone {
                            Image(systemName: "checkmark.square.fill")
                                .resizable()
                                .foregroundColor(
                                    .success.default)
                        } else if repetation == 1 {
                            Image(systemName: "square")
                                .resizable()
                                .foregroundColor(.mono.offblack)
                                .frame(width: .p24, height: .p24)
                                .padding()
                        } else {
                            Text(repetation.formatted())
                                .foregroundColor(.mono.offblack)
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
                                ? .success.dark.opacity(0.25)
                                : .mono.offblack.opacity(0.1)))
                })
            }

            Text(subtitle)
                .foregroundColor(.mono.offblack)
                .scaledFont(.pFootnote)
                .multilineTextAlignment(.leading)
                .fillOnLeading()
        }
        .padding()
        .background(
            RoundedRectangle(cornerSize: .init(width: CGFloat.r8, height: CGFloat.r8))
                .foregroundColor(.mono.input)
                .shadow(radius: .r8)
        )
        .onTapGesture(perform: onDoing)
    }
}
