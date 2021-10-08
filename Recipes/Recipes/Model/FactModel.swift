//
//  FactModel.swift
//  Recipes
//
//  Created by Scott Clampet on 10/4/21.
//

import SwiftUI

//MARK: Fact Model

struct Fact: Identifiable {
    var id = UUID()
    var image: String
    var content: String
}
