//
//  nowTableViewCell.swift
//  Doodle
//
//  Created by t2023-m0088 on 2023/09/05.
//

import UIKit
import MapKit


class nowTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        let imageView1 = UIImageView()
        contentView.addSubview(imageView1)
        imageView1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
//        imageView1.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
//        imageView1.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
        imageView1.widthAnchor.constraint(equalToConstant: 280).isActive = true
        imageView1.heightAnchor.constraint(equalToConstant: 92).isActive = true
        imageView1.image = UIImage(named: "statusTest")
        imageView1.contentMode = .scaleAspectFill
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView1.clipsToBounds = true
        imageView1.layer.cornerRadius = 5
        imageView1.backgroundColor = .clear
        
        let mapView = MKMapView()
        contentView.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        mapView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 92).isActive = true
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 5
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        func creatAnnotation(){
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: 37.27543611, longitude: 127.4432194)
            annotation.title = "예쁜 카페"
            annotation.subtitle = "크리스마스 분위기 잔뜩나요"
            mapView.addAnnotation(annotation)
        }
        
        let label1 = UILabel()
        contentView.addSubview(label1)
        label1.textAlignment = .center
        label1.centerYAnchor.constraint(equalTo: imageView1.centerYAnchor, constant: -2).isActive = true
        label1.centerXAnchor.constraint(equalTo: imageView1.centerXAnchor, constant: 0).isActive = true
        label1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label1.textColor = .white
        label1.layer.shadowOffset = CGSize(width: 2, height: 2)
        label1.layer.shadowOpacity = 0.8
        label1.layer.shadowRadius = 2
        label1.layer.shadowColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "서울 예쁜 카페 발견했어요"
        
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
