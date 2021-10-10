//
//  VideoModel.swift
//  Africa
//
//  Created by Scott Clampet on 10/10/21.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    var thumbnail: String {
        return "video-\(id)"
    }
}
