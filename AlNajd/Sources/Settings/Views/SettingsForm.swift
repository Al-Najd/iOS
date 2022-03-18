//
//  File.swift
//  
//
//  Created by Ahmed Ramy on 12/03/2022.
//

import SwiftUI
import DesignSystem

public struct SettingsForm<Content>: View where Content: View {
    let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            self.content()
                .scaledFont(.pHeadline, .bold)
                .toggleStyle(SwitchToggleStyle(tint: Color.primary.default))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

public struct SettingsRow<Content>: View where Content: View {
    let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            self.content()
                .padding([.top, .bottom])
            Rectangle()
                .fill(Color.mono.line)
                .frame(maxWidth: .infinity, minHeight: 2, idealHeight: 2, maxHeight: 2)
        }
    }
}

public struct SettingsSection<Content>: View where Content: View {
    let content: () -> Content
    let padContents: Bool
    let title: LocalizedStringKey
    
    public init(
        title: LocalizedStringKey,
        padContents: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.padContents = padContents
        self.title = title
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .padding([.bottom], 24)
            
            self.content()
        }
        .padding([.bottom], 40)
    }
}
