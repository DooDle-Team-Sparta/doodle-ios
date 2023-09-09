//
//  MapView.swift
//  MapKitPlay
//
//  Created by 경원이 on 2022/01/21.
//

import Foundation
import UIKit
import SnapKit
import MapKit
import Then


class MapView: UIView{

    let myLocationButtonSize:CGFloat = 40
    let addDoodleButtonSize:CGFloat = 50

    let myLocationButton = CircleButton().then{
        $0.setIcon("scope")
        $0.layer.cornerRadius = 15

    }
    let addDoodleButton = CircleButton().then{
        $0.setIcon("plus")
        $0.backgroundColor = UIColor(red: 1, green: 0.747, blue: 0.096, alpha: 1)
        $0.layer.cornerRadius = 30

    }
    
//    let bottomSheet = UIView().then{
//        $0.backgroundColor = .white
//        $0.layer.cornerRadius = 20
//    }
    
    let map = MKMapView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configure()
        makeConstraints()
        
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        makeConstraints()

    }
    
    func configure() {
        addSubview(map)
//        addSubview(bottomSheet)
        addSubview(myLocationButton)
        addSubview(addDoodleButton)
    }
    
    func makeConstraints() {
        map.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            
        }
        
        myLocationButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(60)
            $0.width.height.equalTo(30)
        }
        addDoodleButton.snp.makeConstraints{
            $0.right.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(170)
            $0.width.height.equalTo(60)

        }
//        bottomSheet.snp.makeConstraints{
//            $0.bottom.equalToSuperview().inset(-20)
//            $0.left.right.equalToSuperview()
//            $0.height.equalTo(150)
//        }
        
    }
    
    
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct mapPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            
            let view = MapView()
            
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif
