//
//  UIView+Extension.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-04.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: [UIView]) {
        
        views.forEach { self.addSubview($0) }
        
    }
    
}
