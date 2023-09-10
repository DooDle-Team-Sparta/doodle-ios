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
    
    var title: String?
    
    var likeCount: Int?
}



class singleton {
    private init(){}
    static var shared = singleton()
    
    var list = UserDefaults.standard.array(forKey: "DoodleList") ?? []
    
    static func saveDoodleList(){
        UserDefaults.standard.set(singleton.shared.list, forKey: "DoodleList")
    }
}
