//
//  IntroScreen.swift
//  DotInversionOnboarding
//
//  Created by Scott Clampet on 11/3/21.
//

import SwiftUI

struct IntroScreen: View {
    @State var currIndex: Int = 0
    
    var body: some View {
        ZStack {
            DotInversion(currIndex: $currIndex)
                .ignoresSafeArea()
            
            //indicators
            HStack(spacing: 10) {
                ForEach(tabs.indices, id: \.self) { index in
                     Circle()
                        .fill(.white)
                        .frame(width: 9, height: 8)
                        .opacity(currIndex == index ? 1 : 0.3)
                        .scaleEffect(currIndex == index ? 1.1 : 0.8)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(25)
            
            Button("Skip") {
                
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            

        }
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreen()
    }
}
