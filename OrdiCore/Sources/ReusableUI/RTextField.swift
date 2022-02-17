//
//  RTextField.swift
//  Trojan
//
//  Created by Ahmed Ramy on 16/01/2022.
//

import SwiftUI
import DesignSystem

public struct RTextField: View {
  let icon: String
  let title: String
  let hint: String
  @Binding var value: String
  
  public init(
    icon: String,
    title: String,
    hint: String,
    value: Binding<String>
  ) {
    self.icon = icon
    self.title = title
    self.hint = hint
    self._value = value
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Label {
        Text(title)
          .scaledFont(.pBody)
      } icon: {
        Image(systemName: icon)
      }.foregroundColor(.mono.offblack.opacity(0.8))
      
      TextField(hint, text: $value)
        .scaledFont(.pBody)
        .padding(.top, .p4)
      
      Divider()
        .background(
          Color.mono.line
        )
    }
  }
}

struct RTextField_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: .p24) {
        Text("Empty State")
        RTextField(
          icon: "envelope",
          title: "Some Field",
          hint: "Some Field",
          value: .constant("")
        )
          .padding()
        
        Text("Filled State")
        RTextField(
          icon: "envelope",
          title: "Some Field",
          hint: "Some Field",
          value: .constant("Hi There!")
        )
          .padding()
      }.padding()
    }
  }
}
