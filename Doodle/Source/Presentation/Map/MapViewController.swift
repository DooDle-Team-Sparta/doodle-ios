//
//  ViewController.swift
//  MapKitPlay
//
//  Created by 경원이 on 2022/01/21.
//

import SnapKit
import UIKit
import MapKit
import CoreLocation
import Then


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let mapView = MapView()
    
    let spartaCoordinate = CLLocationCoordinate2D(latitude: 37.50262815810942, longitude: 127.04461259087897)
    
    let locationManager = CLLocationManager()
    
    
    let width = 177.0
    let height = 56.0
    
    
    
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.map.setRegion(MKCoordinateRegion(center: spartaCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)), animated: true)
        
        
        mapView.map.delegate = self
        locationManager.delegate = self
        
        addCustomPin()
        
        buttonAddAction()
        buttonActions()
        
        mapConfig()
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sheetPresent()
    }
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = spartaCoordinate
        pin.title = "테스트용 어노테이션 타이틀"
        pin.subtitle = "테스트용 서브타이틀"
        mapView.map.addAnnotation(pin)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.snp.makeConstraints{
                $0.width.equalTo(62.1)
                $0.height.equalTo(74.5)
            }
            
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "person")
            imageView.backgroundColor = .orange
            imageView.alpha = 0.5
            imageView.layer.cornerRadius = 10
            annotationView?.addSubview(imageView)
            imageView.snp.makeConstraints{
                $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 6.21, left: 6.21, bottom: 18.64, right: 6.21))
            }
            var subtitleLabel = UILabel()
            subtitleLabel.text = "이름이름"
            subtitleLabel.font = UIFont.systemFont(ofSize: 8)
            annotationView?.addSubview(subtitleLabel)
            subtitleLabel.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().inset(6.21)
            }
            
            
            annotationView?.backgroundColor = UIColor(white: 1, alpha: 0.5)
            annotationView?.layer.cornerRadius = 10
            
            annotationView?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            annotationView?.layer.shadowOpacity = 0.5
            annotationView?.layer.shadowRadius = 4
            annotationView?.layer.shadowOffset = CGSize(width: 10, height: 10)
            annotationView?.layer.shadowPath = nil
            
            annotationView?.canShowCallout = true
            
            
            
            
            let miniButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            miniButton.setImage(UIImage(systemName: "person"), for: .normal)
            miniButton.tintColor = .blue
            annotationView?.rightCalloutAccessoryView = miniButton
            
        } else {
            annotationView?.annotation = annotation
        }
        
        
        return annotationView
    }
    
    
    @objc func annotationTapped() {
        
    }
    
    @objc func MoveLocation() {
        
        mapView.map.showsUserLocation = false
        
        mapView.map.userTrackingMode = .none
        
        mapView.map.setRegion(MKCoordinateRegion(center: spartaCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }
    
    @objc func findMyLocation() {
        
        guard let currentLocation = locationManager.location else {
            checkUserLocationServicesAuthorization()
            return
        }
        
        mapView.map.showsUserLocation = true
        
        mapView.map.setUserTrackingMode(.follow, animated: true)
        
    }
    
    //권한 설정
    
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted:
            print("restricted")
            goSetting()
        case .denied:
            print("denided")
            goSetting()
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wheninuse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("unknown")
        }
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func goSetting() {
        
        let alert = UIAlertController(title: "위치권한 요청", message: "러닝 거리 기록을 위해 항상 위치 권한이 필요합니다.", preferredStyle: .alert)
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
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    func buttonActions() {
        mapView.myLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
    }
    
    func buttonAddAction() {
        mapView.addDoodleButton.addTarget(self, action: #selector(buttonAddClick), for: .touchUpInside)
    }
    
    @objc func buttonAddClick(){
        //        let CreateDoodleViewController = CreateDoodleViewController()
        //        self.navigationController?.pushViewController(CreateDoodleViewController, animated: true)
        
        let createDoodleViewController = CreateDoodleViewController()
        createDoodleViewController.modalPresentationStyle = .fullScreen
        self.present(createDoodleViewController, animated: true)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeDown.direction = .down
        createDoodleViewController.view.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func swipeDown(){
        self.dismiss(animated: true)
    }
        
    func sheetPresent(){
        let bottomViewController = bottomViewController()
        bottomViewController.isModalInPresentation = true
        if let sheet = bottomViewController.sheetPresentationController {
            sheet.preferredCornerRadius = 30
            sheet.detents = [
                .custom(resolver: {
                0.15 * $0.maximumDetentValue
            }),
                .custom(resolver: {
                                 0.55 * $0.maximumDetentValue
                             }),
                .large()]
            sheet.largestUndimmedDetentIdentifier = .large
        }
        self.present(bottomViewController, animated: true)
        
        print("\n\n\n\n\n테스트\(self) - \n\n\n\n\n")
    }

    
    
    private func mapConfig(){
        mapView.map.isRotateEnabled = false
        mapView.map.isPitchEnabled = false
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print("테스트 - \(mapView)")
        
        
    }
    
}




//#if DEBUG
//import SwiftUI
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        // empty
//    }
//    @available(iOS 13.0.0, *)
//    func makeUIViewController(context: Context) -> some UIViewController {
//        MapViewController()
//    }
//}
//@available(iOS 13.0, *)
//struct SnapkitVCRepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ViewControllerRepresentable()
//                .ignoresSafeArea()
//                .previewDisplayName("preview")
//                .previewDevice(PreviewDevice(rawValue: "iphone"))
//        }
//    }
//} #endif

