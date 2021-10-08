//
//  HeaderModel.swift
//  Recipes
//
//  Created by Scott Clampet on 10/4/21.
//

import SwiftUI

//MARK: Header Model

struct Header: Identifiable {
    var id = UUID()
    var image: String
    var headline: String
    var subheadline: String
    
}
