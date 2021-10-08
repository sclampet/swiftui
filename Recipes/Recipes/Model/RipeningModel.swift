//
//  RipeningModel.swift
//  Recipes
//
//  Created by Scott Clampet on 10/5/21.
//

import SwiftUI

struct Ripening: Identifiable {
    var id = UUID()
    var image: String
    var stage: String
    var title: String
    var description: String
    var ripeness: String
    var instruction: String
}
