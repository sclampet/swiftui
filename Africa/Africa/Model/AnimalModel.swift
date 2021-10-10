//
//  AnimalModel.swift
//  Africa
//
//  Created by Scott Clampet on 10/10/21.
//

import Foundation

struct Animal: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    let description: String
    let link: String
    let image: String
    let gallery: [String]
    let fact: [String]
}
