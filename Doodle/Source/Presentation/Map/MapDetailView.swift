//
//  MapDetailView.swift
//  Doodle
//
//  Created by t2023-m0078 on 2023/09/06.
//


import UIKit
import SnapKit
import Then


class MapDetailView: UIView{
    
    var titleText = "집 인테리어 했어요"
    var contentText = "서울시 연남구 낄낄로 136번길, 5F"
    var likeCount = 12.1
    
    var bottomShowButton = CustomButton().then() {
        $0.setText("게시글 보기")
    }
    
    var bottomCancelButton = CustomButton().then() {
        $0.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        $0.setText("취소")
        $0.setTheme()
    }
    
    var stackView = UIStackView()
    
    var circleBtnShare = CircleButton()
    var circleBtnHeart = CircleButton().then() {
        $0.setIcon("heart.fill")
    }
    var circleBtnStar = CircleButton().then() {
        $0.setIcon("star.fill")
    }
    
    
    var imageView = UIImageView().then {
        $0.layer.cornerRadius = 50
        $0.backgroundColor = .orange
        $0.image = UIImage(systemName: "person.fill")
        $0.tintColor = .white
    }
    
    
    
    var mainLabel = UILabel().then { UILabel in
        UILabel.textColor = UIColor(red: 1, green: 0.747, blue: 0.096, alpha: 1)
        UILabel.font = UIFont.boldSystemFont(ofSize: 32)
        UILabel.textAlignment = .center
    }
    var subLabel = UILabel().then { UILabel in
        UILabel.frame = CGRect(x: 0, y: 0, width: 165, height: 0)
        UILabel.textColor = UIColor(red: 0.692, green: 0.692, blue: 0.692, alpha: 1)
        UILabel.font = UIFont.boldSystemFont(ofSize: 12)
    }
    var heartLabel = UILabel().then { UILabel in
        UILabel.frame = CGRect(x: 0, y: 0, width: 49, height: 0)
        UILabel.textColor = UIColor(red: 0.129, green: 0.179, blue: 0.254, alpha: 1)
        UILabel.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constSet()
                
        mainLabel.text = titleText
        subLabel.text = contentText
        heartLabel.text = "♥ \(likeCount)k"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        constSet()

        mainLabel.text = titleText
        subLabel.text = contentText
        heartLabel.text = "♥ \(likeCount)k"
        
    }

    
    
    
    
    private func configure(){
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(heartLabel)
        addSubview(bottomShowButton)
        addSubview(bottomCancelButton)
        addSubview(imageView)

        addSubview(circleBtnShare)
        addSubview(circleBtnStar)
        addSubview(circleBtnHeart)
    }
    
    private func constSet(){
        imageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
            $0.left.right.equalToSuperview().inset(35)
            $0.bottom.equalTo(mainLabel.snp.top).inset(-20)
        }
        mainLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(356)
        }
        subLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLabel).offset(50)
        }
        heartLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subLabel).offset(30)
        }
        bottomShowButton.snp.makeConstraints{
            $0.right.equalToSuperview().inset(40)
            
            $0.left.equalTo(bottomCancelButton.snp.right).offset(20)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(80)
        }
        bottomCancelButton.snp.makeConstraints{
            $0.left.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().inset(50)
            $0.width.equalTo(100)
            $0.height.equalTo(80)
        }
        circleBtnShare.snp.makeConstraints{
            $0.right.equalTo(circleBtnHeart.snp.left).inset(-10)
            $0.top.equalTo(heartLabel).offset(50)
            $0.width.height.equalTo(66)
        }
        circleBtnHeart.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(heartLabel).offset(50)
            $0.width.height.equalTo(66)
        }
        circleBtnStar.snp.makeConstraints{
            $0.left.equalTo(circleBtnHeart.snp.right).offset(10)
            $0.top.equalTo(heartLabel).offset(50)
            $0.width.height.equalTo(66)
        }
    }
    
    @objc func btnTapped(){
        bottomCancelButton.shake()
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct detailPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            
            let view = MapDetailView()
            
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
