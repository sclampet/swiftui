//
//  Tab.swift
//  DotInversionOnboarding
//
//  Created by Scott Clampet on 11/3/21.
//

import SwiftUI

struct Tab: Identifiable {
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var description: String
    var image: String
    var color: Color
}

var tabs: [Tab] = [
    Tab(title: "Series 7", subTitle: "Apple Watch", description: "Some interesting stuff about the new apple watch.", image: "applewatch", color: Color("DarkGrey")),
    Tab(title: "Pro 21'", subTitle: "iPad", description: "Some really interesting stuff about the new ipad.", image: "ipad.landscape", color: Color("Pink")),
    Tab(title: "13 Pro", subTitle: "iPhone", description: "Some super interesting stuff about the new iphone.", image: "iphone", color: Color("Green"))
]
