//
//  OnBoardingPage.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

//To use the custom font on all pages...
let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    @State var showLoginPage: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                //Since we added all custom fonts in Info.plist
                //We can call them with any names now like this...
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("OnBoard")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation {
                    showLoginPage = true                    
                }
            } label: {
                Text("Get started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
            }
            .padding(.horizontal, 30)
            //Adding some adjustments for larger devices
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()

        }
        .padding()
        .padding(.top,  getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("Purple")
        )
        .overlay(
            Group {
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

//Extending view to get screen bounds
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
