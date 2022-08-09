//
//  HomeView.swift
//  
//
//  Created by Ahmed Ramy on 28/02/2022.
//

import SwiftUI
import Common
import Inject
import Localization
import Snap
import ReusableUI

public struct HomeView: View {
    @ObserveInjection var inject
    @State var showDetails: Bool = true
    
    public init() { }
    
    public var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
          VStack {
              HeaderView()
              PrayerSliderView(showDetails: $showDetails)
          }
      }
      .ignoresSafeArea(edges: .top)
      .sheet(isPresented: $showDetails) {
          PrayerDetailsView()
      }
      .enableInjection()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct PrayerDetailsView: View {
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
                
                Text(L10n.fajr)
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(locale: .arabic, .pBody)
                    .multilineTextAlignment(.center)
                
                Text("صلاة الفجر هي الوقت الذي أطلّ الله به على عباده بيوم جديد، فإنّ إدراك الفجر هبة من الله، فيجب شكره عليه عبر طاعته.")
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(locale: .arabic, .pFootnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .p32)
                
                Spacer()
                Text("صلاة الفجر سببٌ من أسباب دفْع الكسل والخمول.")
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(locale: .arabic, .pFootnote)
                    .multilineTextAlignment(.center)
                Spacer()
            }.padding(.top, getSafeArea().top)
            
            SnapDrawer(large: .fraction(0.5), tiny: .height(100), allowInvisible: false, background: BlurView(.systemThinMaterialDark)) { state in
                switch state {
                case .tiny:
                    SubtaskView()
                case .large:
                    VStack {
                        SubtaskView()
                        SubtaskView()
                        SubtaskView()
                        Spacer()
                    }
                }
            }
        }.background(
          Asset.Images.maghribImage.swiftUIImage
              .resizable()
              .aspectRatio(contentMode: .fill)
              .ignoresSafeArea()
              .overlay(
                  Color.mono.offblack.opacity(0.4)
              )
        )
    }
}

struct SubtaskView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("صلاة الفجر")
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote, .bold)
                    .multilineTextAlignment(.center)
                Text("ركعتان")
                    .foregroundColor(.mono.offwhite)
                    .scaledFont(.pFootnote)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button {
                // TODO: - Send done action
            } label: {
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .foregroundColor(.success.darkMode)
                    .frame(width: .p24, height: .p24)
                    .padding()
                    .background(
                        Circle()
                            .foregroundColor(.success.light.opacity(0.25))
                    )
            }

        }
        .padding(.horizontal, .p16)
        .padding(.bottom, .p8)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(spacing: .p4) {
            Text(L10n.alRa3d28)
                .foregroundColor(.mono.offwhite)
                .scaledFont(locale: .arabic, .pFootnote, .bold)
                .multilineTextAlignment(.center)
            
            Label("مارس, ٢٣, ٢٠٢١", systemImage: "calendar")
                .foregroundColor(.mono.offwhite)
                .scaledFont(locale: .arabic, .pFootnote)
                .multilineTextAlignment(.center)
            
            VStack(spacing: .p4) {
                HStack {
                    Text("محصلة اليوم")
                        .foregroundColor(.mono.offwhite)
                        .scaledFont(.textXSmall)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("١/١٨")
                        .foregroundColor(.mono.offwhite)
                        .scaledFont(.textXSmall)
                        .multilineTextAlignment(.center)
                }
                
                ProgressBar(value: .constant(1/18).animation())
                    .frame(height: 5)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, getSafeArea().top)
        .padding(.horizontal, .p8)
        .padding(.bottom, .p16)
        .background(
          Asset.Colors.headerBackgroundColor.swiftUIColor
        )
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    var color: Color = .mono.offwhite
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Group {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(color.opacity(0.75))
                    
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(color)
                    
                }.cornerRadius(45.0)
            }
        }
    }
}

struct ScrollViewRTL<Content: View>: View {
    @ViewBuilder var content: Content
    @Environment(\.layoutDirection) private var layoutDirection
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @ViewBuilder var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            content
                .rotation3DEffect(Angle(degrees: layoutDirection == .rightToLeft ? -180 : 0), axis: (
                    x: CGFloat(0),
                    y: CGFloat(layoutDirection == .rightToLeft ? -10 : 0),
                    z: CGFloat(0)))
            
        }
        .rotation3DEffect(Angle(degrees: layoutDirection == .rightToLeft ? 180 : 0), axis: (
            x: CGFloat(0),
            y: CGFloat(layoutDirection == .rightToLeft ? 10 : 0),
            z: CGFloat(0)))
    }
}

struct PrayerSliderView: View {
    @Binding var showDetails: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: .p8) {
            Text(L10n.prayers)
                .foregroundColor(.mono.offblack)
                .scaledFont(locale: .arabic, .pFootnote, .bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, .p16)
            ScrollViewRTL {
                HStack {
                    ForEach(0..<5) { _ in
                        ZStack {
                            Asset.Images.fajrImage.swiftUIImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            VStack {
                                Spacer()
                                Text("الفجر")
                                    .foregroundColor(.mono.offwhite)
                                    .scaledFont(locale: .arabic, .pFootnote)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .frame(width: 75, height: 100)
                        .cornerRadius(.r16)
                    }
                }
                .padding(.horizontal, .p16)
                .onTapGesture {
                    showDetails = true
                }
            }
        }
    }
}
