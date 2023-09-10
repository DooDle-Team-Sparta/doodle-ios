//
//  MapViewController.swift
//  Doodle
//
//  Created by ThePerfectMartini on 2022/09/04.
//  Edited by yujinkim1 on 2023/09/09.

import CoreLocation
import MapKit
import SnapKit
import Then
import UIKit

class DoodleAnnotation: MKPointAnnotation {
    
    var doodleImage: UIImage?
    
    var content: String?
    
}

class MapViewController: UIViewController {
    
    var address:Address?
    
    let locationManager = CLLocationManager()
    
    let mapView = MapView()
    
    private lazy var cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped(_:)))
    
    override func loadView() {
        
        view = mapView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocation()
        
        addButtonAction()
        
        showMyLocation()
        
        setMapViewConfigure()
        
        loadUserDefaultsAnnotations()
        
        
        print("테스트 - a")
//        URLManager.shared.getJsonData() {result in
//            switch result {
//            case .success(let data):
//                self.address = try? JSONDecoder().decode(Address.self, from: data)
//                print("테스트 - suc \(self.address?.documents)")
//            case .failure(let error):
//                print("테스트 - fail",error)
//            }
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        presentBottomSheet()
        
    }
    
    private func loadUserDefaultsAnnotations(){
        // 첫 로드시 저장되어있던 어노테이션들을 맵에 그려줌
//        if let savedDoodlesData = UserDefaults.standard.object(forKey: "DoodleGroup") as? Data,
        for i in singleton.shared.list {
            if let savedDoodles = try? JSONDecoder().decode(DoodleMarker.self, from: i as! Data),
               let latitude  = savedDoodles.location?["latitude"],
               let longitude  = savedDoodles.location?["longitude"],
               let image  = UIImage(data: savedDoodles.doodle!) {
                
                let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                drawAnnotation(location: location, image: image)
            }
        }
    }
    
    private func drawCurrentAddedAnnotation(){
        // 어노테이션 추가시 추가된 하나의 어노테이션을 맵에 그려줌
        if let savedDoodles = try? JSONDecoder().decode(DoodleMarker.self, from: singleton.shared.list.last as! Data),
           let latitude  = savedDoodles.location?["latitude"],
           let longitude  = savedDoodles.location?["longitude"],
           let image  = UIImage(data: savedDoodles.doodle!) {
            
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            drawAnnotation(location: location, image: image)
        }
    }
    
    private func drawAnnotation(location: CLLocationCoordinate2D, image:UIImage){
        let annotation = DoodleAnnotation()
        
        annotation.coordinate = location
        
        annotation.doodleImage = image
        
        mapView.map.addAnnotation(annotation)
    }
    
    private func setLocation() {
        
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
        
        mapView.map.delegate = self
        
    }
    
    private func setMapViewConfigure() {
        
        mapView.map.isRotateEnabled = false
        
        mapView.map.isPitchEnabled = false
        
    }
    
    func goSetting() {
        
        let alert = UIAlertController(title: "위치권한 요청", message: "낙서 추가를 위해 항상 위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            // 열 수 있는 url 이라면, 이동
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
            
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showMyLocation() {
        
        mapView.myLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
        
    }
    
    private func addButtonAction() {
        
        mapView.addDoodleButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
    }
    
    private func annotationClick(_ annotation: MKAnnotationView) {
        let anno = annotation.annotation
        
        let imageView = annotation.subviews[0] as? UIImageView
        let image = imageView?.image ?? UIImage()
        
        let latitude = anno?.coordinate.latitude ?? 0.0
        let longitude = anno?.coordinate.longitude ?? 0.0
        
        self.dismiss(animated: false)
        
        let mapDetailViewController = MapDetailViewController()
        
        mapDetailViewController.mapDetailView.imageView.image = image
        
        mapDetailViewController.mapDetailView.mainLabel.text = "콘텐츠변경?"
        
        mapDetailViewController.mapDetailView.subLabel.text = "위도 : \(latitude) 경도 : \(longitude)"
        
        mapDetailViewController.mapDetailView.heartLabel.text = "♥ \(999.123123)k"
        
        mapDetailViewController.closure = {self.presentBottomSheet()}
        
        mapDetailViewController.modalPresentationStyle = .pageSheet
        
        self.present(mapDetailViewController, animated: true)
        
    }
    
    func presentBottomSheet() {
        let bottomViewController = BottomViewController()
        bottomViewController.isModalInPresentation = true
        if let sheet = bottomViewController.sheetPresentationController {
            sheet.preferredCornerRadius = 30
            sheet.detents = [
                .custom(resolver: {
                    0.10 * $0.maximumDetentValue
                }),
                .custom(resolver: {
                    0.55 * $0.maximumDetentValue
                }),
                .large()]
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        self.present(bottomViewController, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotationView) {
        print("테스트 - \(annotation.annotation?.coordinate)")
        
        annotationClick(annotation)
        
    }
}

//MARK: - Core Location Location Manager
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        let authorizationStatus = manager.authorizationStatus
        
        switch authorizationStatus {
            
        case .notDetermined: manager.requestWhenInUseAuthorization()
            
        case .restricted, .denied: goSetting()
            
        case .authorizedAlways, .authorizedWhenInUse: manager.startUpdatingLocation()
            
        @unknown default: break
            
        }
        
        if #available(iOS 14.0, *) {
            
            switch manager.accuracyAuthorization {
                
            case .fullAccuracy: print("full")
                
            case .reducedAccuracy: print("reduced")
                
            @unknown default: print("unknown")
                
                
            }
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        locationManagerDidChangeAuthorization(manager)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            print("현재 나의 위치 정보: \(location)")
            
            manager.stopUpdatingLocation()
            
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            
            mapView.map.setRegion(coordinateRegion, animated: true)
            
        }
        
    }
    
}

//MARK: - Map Kit Map View
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self),
              let doodleAnnotation = annotation as? DoodleAnnotation else { return nil }
        
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.snp.makeConstraints{
                $0.width.equalTo(62.1)
                $0.height.equalTo(74.5)
            }
            
            let imageView = UIImageView()
            
            if let doodleImage = doodleAnnotation.doodleImage {
                imageView.image = doodleImage
                
                imageView.backgroundColor = .orange
                imageView.alpha = 1
                
                imageView.layer.cornerRadius = 10
                
                annotationView?.addSubview(imageView)
                
                imageView.snp.makeConstraints{
                    
                    $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 6.21, left: 6.21,
                                                                   bottom: 18.64, right: 6.21))
                }
                
            }
            
            annotationView?.backgroundColor = UIColor(white: 1, alpha: 0.5)
            
            annotationView?.layer.cornerRadius = 10
            
            annotationView?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            
            annotationView?.layer.shadowOpacity = 0.5
            
            annotationView?.layer.shadowRadius = 4
            
            annotationView?.layer.shadowOffset = CGSize(width: 10, height: 10)
            
            annotationView?.layer.shadowPath = nil
            
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
}

//MARK: - Custom Action
extension MapViewController {
    
    @objc func findMyLocation() {
        
        guard let currentLocation = locationManager.location else { return }
        
        mapView.map.showsUserLocation = true
        
        let coordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate,
                                                  latitudinalMeters: 1000,
                                                  longitudinalMeters: 1000)
        
        mapView.map.setRegion(coordinateRegion, animated: true)
        
        mapView.map.setUserTrackingMode(.follow, animated: true)
        
    }
    
    @objc func changeLocation() {
        
        mapView.map.showsUserLocation = false
        
        mapView.map.userTrackingMode = .none
        
    }
    
    @objc func addButtonTapped() {
        
        dismiss(animated: false)
        
        let createDoodleViewController = CreateDoodleViewController()
        
        createDoodleViewController.executeDrawCurrentAnnotationClosure = {self.drawCurrentAddedAnnotation()} // 작성한 어노테이션 그려주는 함수 전달
        
        createDoodleViewController.navigationItem.leftBarButtonItem = cancelButton
        
        createDoodleViewController.modalPresentationStyle = .fullScreen
        
        self.present(createDoodleViewController, animated: true)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDown))
        
        swipeGesture.direction = .down
        
        createDoodleViewController.view.addGestureRecognizer(swipeGesture)
        
    }
    
    @objc func swipeToDown(){
        
        self.dismiss(animated: true)
        
        presentBottomSheet()
        
    }
    
    @objc func cancelButtonTapped(_ button: UIButton) {
        
        dismiss(animated: true)
        
    }
    
}



// MARK: - Address
struct Address: Codable {
    let meta: Meta
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable {
    let regionType, addressName, region1DepthName, region2DepthName: String
    let region3DepthName, region4DepthName, code: String
    let x, y: Double

    enum CodingKeys: String, CodingKey {
        case regionType = "region_type"
        case addressName = "address_name"
        case region1DepthName = "region_1depth_name"
        case region2DepthName = "region_2depth_name"
        case region3DepthName = "region_3depth_name"
        case region4DepthName = "region_4depth_name"
        case code, x, y
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
    }
}
