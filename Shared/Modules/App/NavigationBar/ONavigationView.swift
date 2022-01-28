//
//  ONavigationView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 25/01/2022.
//

import SwiftUI
import DesignSystem
import Utils
import ReusableUI
import PreviewableView
import ComposableArchitecture

struct ONavigationBar: View {
  @State var dragOffset: CGFloat = 0.0
  
  var store: Store<DateState, DateAction>
  
  private var topHeight: CGFloat {
    dragOffset.clamped(to: 0...maxHeight)
  }
  
  private var canExpand: Bool {
    dragOffset > expandThreshold
  }
  
  private var isDragging: Bool {
    (dragOffset != 0.0 && dragOffset != topHeight)
  }
  
  private var canCollapse: Bool {
    !canExpand && isDragging
  }
  
  private var didExpand: Bool {
    topHeight == maxHeight
  }
  
  private var maxHeight: CGFloat {
    getScreenSize().height - (200)
  }
  
  private var expandThreshold: CGFloat { getScreenSize().height * 0.2 }
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 0) {
        createTopView(store)
        
        createDaysSlider(
          store
        )
        
        RoundedRectangle(cornerRadius: CGFloat(2.5).adaptRatio())
          .fill(Color.mono.line)
          .frame(width: CGFloat(50).adaptRatio(), height: CGFloat(5).adaptRatio())
          .stay(.dark)
          .padding(.vertical, .p4.adaptRatio())
          .fillAndCenter()
          .background(Color.primary.background)
          .zIndex(-1)
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
      .gesture(
        DragGesture(coordinateSpace: .global)
          .onChanged { gesture in
            withAnimation(.easeInOut) {
              dragOffset = gesture.translation.height
            }
          }.onEnded { gesture in
            withAnimation(.easeInOut(duration: 0.65)) {
              if canExpand {
                dragOffset = maxHeight
                HapticService.main.generate(feedback: .success)
              } else if canCollapse {
                dragOffset = .zero
                HapticService.main.generate(feedback: .warning)
              }
            }
          }
      )
    }
  }
  
  @ViewBuilder
  private func createDaysSlider(
    _ store: Store<DateState, DateAction>
  ) -> some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: .p8.adaptRatio()) {
        HStack(spacing: 0) {
          HorizontalWeekSliderView(
            viewStore.currentDay,
            viewStore.currentWeek,
            { viewStore.send(.onChange(currentDay: $0)) }
          )
        }.frame(maxWidth: .infinity)
          .stay(.light)
          .padding([.horizontal, .bottom], .p16.adaptRatio())
          .padding(.top, .p4.adaptRatio())
          .background(
            Color
              .primary
              .dark
              .cornerRadius(.r16, corners: [.bottomLeft, .bottomRight])
              .ignoresSafeArea()
              .stay(.light)
          )
          .shadow(radius: 4.adaptRatio(), x: 0, y: 4.adaptRatio())
          .background(
            Color
              .primary
              .background
              .ignoresSafeArea()
          )
      }
    }
  }
  
  @ViewBuilder
  private func createTopView(
    _ store: Store<DateState, DateAction>
  ) -> some View {
    WithViewStore(store) { viewStore in
      ZStack {
        Color
          .primary
          .dark
          .stay(.light)
          .frame(height: topHeight)
          .ignoresSafeArea(edges: .top)
        if canExpand {
          VStack(spacing: .p8.adaptRatio()) {
            VStack(alignment: .leading, spacing: .p8.adaptRatio()) {
              HStack(spacing: .p8.adaptRatio()) {
                Image(systemName: "map.circle")
                  .resizable()
                  .frame(width: .p24.adaptRatio(), height: .p24.adaptRatio())
                  .foregroundColor(.mono.offblack)
                
                Text("Al Najd".localized)
                  .font(.pTitle3.bold())
                  .foregroundColor(.mono.offblack)
                Spacer()
                Button(action: {}, label: {
                  Image(systemName: "gear")
                    .resizable()
                    .frame(width: .p24.adaptRatio(), height: .p24.adaptRatio())
                    .foregroundColor(.mono.offblack)
                })
              }
              
              Text("\("hud-88".localized)")
                .font(
                  FontManager
                    .shared
                    .getFont(
                      locale: .arabic,
                      type: .sansSerif,
                      category: .text,
                      scale: .medium,
                      weight: .bold
                    ).toSwiftUIFont()
                )
                .foregroundColor(.mono.offblack.opacity(0.65))
                .fixedSize(horizontal: false, vertical: true)
            }.padding(.p16.adaptRatio())
            
            if didExpand {
              OCalendarView(store)
                .padding(.p16.adaptRatio())
                .background(
                  Rectangle()
                    .fill(Color.mono.offwhite.opacity(0.35))
                    .cornerRadius(.r24.adaptRatio())
                    .padding(.horizontal, .p16.adaptRatio())
                    .padding(.top, .p4.adaptRatio())
                )
            }
          }
          .padding(.bottom, .p8.adaptRatio())
        }
      }
      .background(
        Color
          .primary
          .dark
          .stay(.light)
          .ignoresSafeArea(edges: .top)
      )
      .stay(.dark)
    }
  }
}

struct ONavigationView_Previews: PreviewProvider {
  static var previews: some View {
    PreviewableView([.darkMode]) {
      MainTabView(store: .mainRoot)
    }
  }
}

extension Calendar {
  
  // Get Today's month
  var monthDays: [Date] {
    let today = startOfDay(for: .now)
    let numberOfDays = range(of: .day, in: .month, for: today)!.count
    
    let firstDay = today.adding(.day, value: -(1 + today.day))
    
    return (2...numberOfDays).map {
      firstDay.adding(.day, value: $0)
    }
  }
}
