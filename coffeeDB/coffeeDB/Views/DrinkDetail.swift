//
//  DrinkDetail.swift
//  coffeeDB
//
//  Created by Scott Clampet on 7/8/19.
//  Copyright © 2019 sc. All rights reserved.
//

import SwiftUI

struct DrinkDetail : View {
    var drink:Drink
    
    var body: some View {
        List {
            ZStack(alignment: .bottom) {
                Image(drink.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    Rectangle()
                        .frame(height: 80)
                        .opacity(0.35)
                        .blur(radius: 10)
                        HStack {
                            VStack(alignment:.leading, spacing: 8) {
                                Text(drink.name)
                                    .color(.white)
                                    .font(.largeTitle)
                            }
                            .padding(.leading)
                            .padding(.bottom)
                            Spacer()
                        }
                    }
            .listRowInsets(EdgeInsets())//extends image to width of screen
            VStack(alignment: .leading) {
                Text(drink.description)
                    .color(.primary)
                    .font(.body)
                    .lineLimit(nil) //this works even though the canvas flickers
                    .lineSpacing(12)
                    HStack {
                        Spacer()
                        OrderButton()
                        Spacer()
                    }.padding(.top, 50)
            }
            .padding(.top)
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        
    }
}

struct OrderButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Order Now")
            }.frame(width: 200, height: 50)
            .foregroundColor(Color.white)
            .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

#if DEBUG
struct DrinkDetail_Previews : PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData[3])
    }
}
#endif
