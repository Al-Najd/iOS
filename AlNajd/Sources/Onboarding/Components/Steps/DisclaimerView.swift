//
//  SwiftUIView.swift
//  
//
//  Created by Ahmed Ramy on 24/02/2022.
//

import SwiftUI

struct DisclaimerView: View {
    var body: some View {
        buildStep0View()
    }
    
    @ViewBuilder
    func buildStep0View() -> some View {
        Group {
            Group {
                Text("In the memory of my passed away".localized)
                    .foregroundColor(.mono.line)
                
                Text("\nGrand Mother".localized)
                    .foregroundColor(.mono.offwhite)
                    .fontWeight(.bold)
            }
            .scaledFont(.pTitle1)
            
            Group {
                Text("I ask of you to ".localized)
                
                Text("Receit ".localized)
                
                Text("Al Fatihaa".localized)
                    .scaledFont(.pTitle1, .bold)
                    .foregroundColor(.mono.offwhite)
                
                Text("to her".localized)
                Text("And to all our passed away closed ones.\n❤️".localized)
            }
            .foregroundColor(.mono.label)
            .scaledFont(.pTitle1)
            
            
            Text("May we reunite again with them in the highest paradise along all of those who preceeded us\n🤲".localized)
                .scaledFont(.pHeadline, .bold)
                .foregroundColor(.mono.line)
        }.multilineTextAlignment(.center)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerView()
    }
}
