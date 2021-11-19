//
//  PlansView.swift
//  Al Najd (iOS)
//
//  Created by Ahmed Ramy on 18/11/2021.
//

import SwiftUI
import Schedule
import SPPermissions

final class PlansState: ObservableObject {
  @Published var plans: [ANPlan] = [
    .init(
      interval: 25.minutes,
      action: .estigphar,
      title: "Operation: White Heart".localized,
      description: """
                  Operation White Heart is the first Operation of Al Najd, where you, dear believer, will engage on a journey of Estigphar The operation might be difficult, but it ease up lots of future Plans!
                  """.localized,
      purpose: "30x Estigphar / 25 mins".localized,
      image: Image("heart-dynamic-clay"),
      brandColor: Color.primary1
    )
  ]
}

struct PlansView: View {
  @EnvironmentObject var state: PlansState
  @State var shouldShowPermissionList: Bool = false
  
  var body: some View {
    VStack {
      VStack(alignment: .leading, spacing: .p8) {
        Text("Oh hey!, you made it to the plans page!".localized)
          .font(.pHeadline)
          .foregroundColor(.mono.label)
          .multilineTextAlignment(.leading)
          .padding(.horizontal, .p8)
        Text("Good Job!".localized)
          .font(.pSubheadline)
          .foregroundColor(.mono.offblack)
          .padding(.vertical, .p8)
          .padding(.horizontal, .p8)
        Text("We currently have only 1 plan for Estigphar, but more is Coming isA".localized)
          .font(.pSubheadline)
          .foregroundColor(.mono.label)
          .padding(.horizontal, .p8)
      }
      .padding(.p8)
      .background(Color.mono.background)
      .overlay(
        RoundedRectangle(cornerRadius: .p8)
          .stroke(Color.mono.line, lineWidth: 2.5)
      )
      .padding(.bottom, .p32)
      
      ForEach(state.plans) { plan in
        VStack(spacing: .p16) {
          HStack {
            plan
              .image
              .resizable()
              .frame(width: 65, height: 65)
              .background(plan.brandColor.light)
              .clipShape(
                Circle()
              )
              .overlay(
                Circle()
                  .strokeBorder(.white, lineWidth: 2)
              )
              .shadow(color: plan.brandColor.light, radius: 4, x: 0, y: 0)
              .padding(.leading, .p4)
            
            
            VStack(alignment: .leading) {
              Text(plan.title)
                .font(.pFootnote)
                .foregroundColor(.mono.ash)
              
              Text(plan.purpose)
                .font(.pFootnote)
                .foregroundColor(.mono.label)
            }
            .padding(.horizontal)
          }
          .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
            .background(
              RoundedRectangle(
                cornerRadius: 40,
                style: .continuous
              ).fill(
                plan.brandColor.background
              )
            )
          
          Text(plan.description)
            .font(.pFootnote)
            .foregroundColor(.mono.label)
            .padding(.vertical, .p16)
          
          Button(
            action: {
              if ANPermission.notifications.canUse() == false {
                shouldShowPermissionList = true
              } else {
                SchedulerService.schedule(plan)
              }
            },
            label: {
              Text("Embrace the Change".localized)
                .font(.pFootnote)
                .foregroundColor(.primary1.dark)
                .padding(.p16)
                .background(
                  Capsule().fill(Color.primary1.background)
                )
                .overlay(
                  Capsule()
                    .strokeBorder(
                      Color.primary1.dark,
                      lineWidth: 3
                    )
                )
            }
          )
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: .p16)
            .stroke(Color.mono.line, lineWidth: 2.5)
        )
      }
      Spacer()
    }
    .padding(.p16)
    .sheet(isPresented: $shouldShowPermissionList, content: {
      SPPermissionsList(permissions: [ANPermission.notifications.toSPPermission()])
    })
  }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
      PlansView()
        .preferredColorScheme(.dark)
        .environmentObject(PlansState())
    }
}

