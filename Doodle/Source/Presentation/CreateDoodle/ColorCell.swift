//
//  ColorCell.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-06.
//

import SnapKit
import Then
import UIKit

class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ColorCell"
    
    lazy var checkmarkImageView = UIImageView().then({
        
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
        
    })
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUI()
        setLayout()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override var isSelected: Bool {
        
        didSet { updateSelection() }
        
    }
    
    func setUI() {
        
        contentView.addSubview(checkmarkImageView)
        
    }
    
    func setLayout() {
        
        checkmarkImageView.snp.makeConstraints{ constraint in
            constraint.center.equalToSuperview()
            constraint.width.equalToSuperview().multipliedBy(0.8)
            constraint.height.equalTo(20)
        }
        
    }
    
    func configure(color: UIColor) {
        
        contentView.backgroundColor = color
        contentView.layer.cornerRadius = CGFloat(8)
        
    }
    
    func updateSelection() {
        
        if isSelected {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self?.checkmarkImageView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.transform = .identity
                self?.checkmarkImageView.isHidden = true
            }
        }
        
    }
    
}
