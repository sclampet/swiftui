//
//  ContentView.swift
//  coffeeDB
//
//  Created by Scott Clampet on 7/8/19.
//  Copyright © 2019 sc. All rights reserved.
//

import SwiftUI

struct Home : View {
    
    var categories:[String:[Drink]] {
        .init(
            grouping: drinkData,
            by: {$0.category.rawValue}
        )
    }
    
    var body: some View {
        NavigationView {
            List(categories.keys.sorted().identified(by: \String.self)) { key in
                DrinkRow(categoryName: "\(key) Drinks".uppercased(), drinks: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom)
            }
            .navigationBarTitle(Text("COFFEE MENU"))
        }
    }
}

#if DEBUG
struct Home_Previews : PreviewProvider {
    static var previews: some View {
        Home()
            .environment(\.colorScheme, .dark)
    }
}
#endif
