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

struct PrayerDetailsView: View {
    @ObserveInjection var inject
    var prayer: ANPrayer
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Label("مارس, ٢٣, ٢٠٢١", systemImage: "calendar")
                        .foregroundColor(.mono.offwhite)
                        .scaledFont(locale: .arabic, .pFootnote)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button {
                        // TODO: - Send dismiss action
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .foregroundColor(.mono.offwhite)
                            .scaledFont(locale: .arabic, .pFootnote)
                            .frame(width: 12, height: 12)
                            .padding(.p8)
                            .background(
                                Circle()
                                    .foregroundColor(.mono.offwhite.opacity(0.25))
                            )
                    }
                }.padding()
                
                Text(prayer.title)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(locale: .arabic, .pBody)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }.padding(.top, getSafeArea().top)
            
            Spacer()
            
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
                            SubtaskView(prayer)
                            ScrollView(.vertical, showsIndicators: false) {
                                Text(L10n.sunnah)
                                    .foregroundColor(.mono.offwhite)
                                    .scaledFont(.pFootnote, .bold)
                                    .multilineTextAlignment(.center)
                                    .if(prayer.sunnah.isEmpty, transform: { _ in EmptyView() })
                                ForEach(prayer.sunnah) {
                                    SubtaskView($0).frame(maxWidth: .infinity)
                                }
                                Text(L10n.azkar)
                                    .foregroundColor(.mono.offwhite)
                                    .scaledFont(.pFootnote, .bold)
                                    .multilineTextAlignment(.center)
                                ForEach(prayer.afterAzkar) {
                                    RepeatableSubtaskView($0).frame(maxWidth: .infinity)
                                }
                            }
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
            .impact(.light)
            .spring(.p32)
            .padding(.bottom, getSafeArea().bottom)
            .padding(.bottom, .p16)

        }.background(
            prayer.image
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

struct PrayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerDetailsView(prayer: .fajr)
    }
}

extension ANPrayer {
    var title: String {
        L10n.prayerTitle(name)
    }
    
    var subtitle: String {
        L10n.raqaatCount(raqaat)
    }
    
    var image: Image {
        switch self {
        case .fajr:
            return Asset.Images.fajrImage.swiftUIImage
        case .dhuhr:
            return Asset.Images.dhuhrImage.swiftUIImage
        case .asr:
            return Asset.Images.asrImage.swiftUIImage
        case .maghrib:
            return Asset.Images.maghribImage.swiftUIImage
        case .isha:
            return Asset.Images.ishaImage.swiftUIImage
        default:
            return Asset.Images.fajrImage.swiftUIImage
        }
    }
    
    var color: Color {
      switch self {
      case .fajr:
        return Asset.Colors.fajrColor.swiftUIColor
      case .sunrise:
        return Asset.Colors.duhaColor.swiftUIColor
      case .dhuhr:
        return Asset.Colors.dhuhrColor.swiftUIColor
      case .asr:
        return Asset.Colors.asrColor.swiftUIColor
      case .maghrib:
        return Asset.Colors.maghribColor.swiftUIColor
      case .isha:
        return Asset.Colors.ishaaColor.swiftUIColor
      default:
          return Asset.Colors.fajrColor.swiftUIColor
      }
    }
}

extension ANSunnah {
    var title: String {
        L10n.sunnahTitle(name, affirmation.text)
    }
    
    var subtitle: String {
        return L10n.sunnahSubtitle(name, position.text, L10n.raqaatCount(raqaat))
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
