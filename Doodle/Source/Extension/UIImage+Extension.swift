//
//  UIImage+Extension.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-08.
//

import UIKit

extension UIImage {
    
    static let undoImage = UIImage(systemName: "arrow.uturn.backward.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
    static let redoImage = UIImage(systemName: "arrow.uturn.forward.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
    static let clearImage = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
    static let eyeImage = UIImage(systemName: "eye.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
    static let eyeSlashImage = UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
    static let uncheckedImage = UIImage(named: "unchecked", in: nil, with: UIImage.SymbolConfiguration(scale: .large))
    
    static let checkedImage = UIImage(named: "checked", in: nil, with: UIImage.SymbolConfiguration(scale: .large))
    
}
