//
//  DrinkItem.swift
//  coffeeDB
//
//  Created by Scott Clampet on 7/8/19.
//  Copyright © 2019 sc. All rights reserved.
//

import SwiftUI

struct DrinkItem : View {
    var drink:Drink
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image(drink.imageName)
                .resizable()
                .renderingMode(.original) //makes sure we always see this image and that it doesn't take anything from the environment
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            VStack(alignment: .leading, spacing: 5.0) {
                Text(drink.name)
                    .color(.primary)
                    .font(.headline)
                Text(drink.description)
                    .font(.subheadline)
                    .color(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(height: 40)
            }
        }
    }
}

#if DEBUG
struct DrinkItem_Previews : PreviewProvider {
    static var previews: some View {
        DrinkItem(drink: drinkData[0])
    }
}
#endif
