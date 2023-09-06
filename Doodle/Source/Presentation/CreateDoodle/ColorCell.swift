//
//  ColorCell.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-06.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ColorCell"
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure(color: CGColor) {
        
        contentView.backgroundColor = UIColor(cgColor: color)
        
    }
    
}
