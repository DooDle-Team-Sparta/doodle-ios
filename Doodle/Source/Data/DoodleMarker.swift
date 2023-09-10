//
//  DoodleMarker.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-09.
//

import Foundation

class DoodleMarker: Codable {
    
    var username: String?
    
    var doodle: Data?
    
    var location: [String: Double]?
    
}
