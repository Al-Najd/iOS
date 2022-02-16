//
//  RSecureField.swift
//  Trojan
//
//  Created by Ahmed Ramy on 16/01/2022.
//

import SwiftUI
import DesignSystem

public struct RSecureField: View {
  let icon: String
  let title: String
  let hint: String
  @Binding var value: String
  @Binding var showPassword: Bool
  
  public init(
    icon: String,
    title: String,
    hint: String,
    value: Binding<String>,
    showPassword: Binding<Bool>
  ) {
    self.icon = icon
    self.title = title
    self.hint = hint
    self._value = value
    self._showPassword = showPassword
  }
    
  public var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Label {
        Text(title)
          .scaledFont(.pBody)
      } icon: {
        Image(systemName: icon)
      }.foregroundColor(.mono.offblack.opacity(0.8))
      
      getField()
        .scaledFont(.pBody)
        .padding(.top, .p4)
      
      Divider()
        .background(
          Color.mono.line
        )
    }.overlay(
      Group {
        Button {
          withAnimation {
            showPassword.toggle()
          }
        } label: {
          Text(
            showPassword
            ? "Hide"
            : "Show"
          )
            .scaledFont(
              .pFootnote
            )
            .foregroundColor(.primary.default)
        }.offset(y: .p16)
      },
      alignment: .trailing
    )
  }
  
  @ViewBuilder
  private func getField() -> some View {
    if !showPassword {
      SecureField(hint, text: $value)
    } else {
      TextField(hint, text: $value)
    }
  }
}

struct RSecureField_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: .p24) {
        Text("Empty State")
        RSecureField(
          icon: "envelope",
          title: "Some Field",
          hint: "Some Field",
          value: .constant(""),
          showPassword: .constant(false)
        )
          .padding()
        
        Text("Filled State")
        RSecureField(
          icon: "envelope",
          title: "Some Field",
          hint: "Some Field",
          value: .constant("Hi There!"),
          showPassword: .constant(false)
        )
          .padding()
        
        Text("Shown State")
        RSecureField(
          icon: "envelope",
          title: "Some Field",
          hint: "Some Field",
          value: .constant("Hi There!"),
          showPassword: .constant(true)
        )
          .padding()
          
      }.padding()
    }
  }
}
