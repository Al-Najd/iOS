//
//  PrayerDetailsView.swift
//  
//
//  Created by Ahmed Ramy on 10/08/2022.
//

import SwiftUI
import DesignSystem
import Entities
import ReusableUI
import Localization
import Inject
import Utils
import Drawer
import ComposableArchitecture

public struct PrayerDetailsView: View {
    @ObserveInjection var inject
    let store: Store<PrayerDetailsState, PrayerDetailsAction>
    
    public init(store: Store<PrayerDetailsState, PrayerDetailsAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack(alignment: .bottom) {
                VStack {
                    HStack {
						Label(viewStore.date, systemImage: "calendar")
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(.pFootnote)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button {
                            viewStore.send(.dismiss, animation: .default)
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(.mono.offwhite)
                                .scaledFont(.pFootnote)
                                .frame(width: 12, height: 12)
                                .padding(.p8)
                                .background(
                                    Circle()
                                        .foregroundColor(.mono.offwhite.opacity(0.25))
                                )
                        }
                    }.padding()
                    
                    Text(viewStore.prayer.title)
                        .foregroundColor(.mono.offwhite)
                        .scaledFont(locale: .arabic, .pBody)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                Drawer(startingHeight: 50) {
                    ZStack {
                        BlurView(.systemChromeMaterialDark)
                            .cornerRadius(.r24 + .r8)
                            .shadow(radius: 100)
                        
                        VStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 3.0)
                                .foregroundColor(.gray)
                                .frame(width: 30.0, height: 6.0)
                                .padding(.top, .p4)
                                .padding(.bottom, .p8)
                            
                            VStack {
                                SubtaskView(viewStore.prayer) { viewStore.send(.onDoingPrayer, animation: .default) }
                                ScrollView(.vertical, showsIndicators: false) {
                                    Text(L10n.sunnah)
                                        .foregroundColor(.mono.offwhite)
                                        .scaledFont(.pFootnote, .bold)
                                        .multilineTextAlignment(.center)
                                        .if(viewStore.prayer.sunnah.isEmpty, transform: { _ in EmptyView() })
                                            ForEach(viewStore.prayer.sunnah) { sunnah in
                                            SubtaskView(sunnah) {
                                                viewStore.send(.onDoingSunnah(sunnah), animation: .default)
                                            }.frame(maxWidth: .infinity)
                                        }
                                    Text(L10n.azkar)
                                        .foregroundColor(.mono.offwhite)
                                        .scaledFont(.pFootnote, .bold)
                                        .multilineTextAlignment(.center)
                                    ForEach(viewStore.prayer.afterAzkar) { zekr in
                                        RepeatableSubtaskView(zekr) {
                                            viewStore.send(.onDoingZekr(zekr), animation: .default)
                                        }.frame(maxWidth: .infinity)
                                    }
								}
								.padding(.bottom, getSafeArea().bottom * 7)
                            }
                        }
                        .padding(.top)
                    }
                }
                .rest(at: .constant(
                    [
                        50,
                        0.25.asPercentage(),
                        0.5.asPercentage()
                    ]
                ))
                .impact(.heavy)
                .spring(.p32)
                .padding(.bottom, getSafeArea().bottom)
                .padding(.bottom, .p16)
                
            }.background(
                viewStore.prayer.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .overlay(
                        Color.mono.offblack.opacity(0.5)
                    )
            )
            .enableInjection()
        }
    }
}

extension Double {
    func asPercentage() -> CGFloat {
        getScreenSize().height * self
    }
}

extension CGFloat {
    func asPercentage() -> CGFloat {
        getScreenSize().height * self
    }
}
