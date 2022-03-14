//
//  Ring.swift
//  FitnessAppUI
//
//  Created by Scott Clampett on 3/14/22.
//

import SwiftUI


//MARK: Progress Ring Model and Sample Data
struct Ring: Identifiable {
    var id = UUID().uuidString
    var progress: CGFloat
    var value: String
    var keyIcon: String
    var keyColor: Color
    var isText: Bool = false
}

var rings: [Ring] = [
    Ring(progress: 72, value: "Steps", keyIcon: "figure.walk", keyColor: Color("Green")),
    Ring(progress: 36, value: "Calories", keyIcon: "flame.fill", keyColor: Color("Red")),
    Ring(progress: 91, value: "Sleep time", keyIcon: "😴", keyColor: Color("Purple"),isText: true)
]
