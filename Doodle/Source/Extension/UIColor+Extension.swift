//
//  UIColor+Extension.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-08.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        
        var hexFormat: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if hexFormat.hasPrefix("#") {
            
            hexFormat = String(hexFormat.dropFirst())
            
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexFormat).scanHexInt64(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: alpha)
        
    }
}
