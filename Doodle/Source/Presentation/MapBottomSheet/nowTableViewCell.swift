//
//  nowTableViewCell.swift
//  Doodle
//
//  Created by t2023-m0088 on 2023/09/05.
//

import UIKit

class nowTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }

    func setView(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.bottomAnchor , constant: 0),
            self.heightAnchor.constraint(equalToConstant: 90),
            self.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 20),
            self.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -20),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{
            
            contentView.layer.borderWidth = 2
            
        } else {
            
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.gray.cgColor
            contentView.layer.cornerRadius = 5

        }
    }

}
