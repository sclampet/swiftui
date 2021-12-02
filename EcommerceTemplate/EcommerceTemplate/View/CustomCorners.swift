//
//  CustomCorners.swift
//  EcommerceTemplate
//
//  Created by Scott Clampet on 12/2/21.
//

import SwiftUI

struct CustomCorners: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

