//
//  SharedDataViewModel.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/5/21.
//

import SwiftUI

class SharedDataViewModel: ObservableObject {
    //MARK: Detail Product Data
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    //MARK: Matched geometry effect from search page
    @Published var fromSearchPage: Bool = false
    
    //MARK: Like Products
    @Published var likedProducts: [Product] = []
    
    //MARK: Basket Products
    @Published var cartProducts: [Product] = []
}
