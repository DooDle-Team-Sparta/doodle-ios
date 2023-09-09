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

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    let mapView = MapView()
    
    override func loadView() {
        
        view = mapView
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setLocation()
        
        buttonAddAction()
        
        buttonActions()
        
        setMapViewConfigure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        presentBottomSheet()
        
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
    
    func buttonActions() {
        
        mapView.myLocationButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
        
    }
    
    func buttonAddAction() {
        
        mapView.addDoodleButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
    }
    
    func annotationClick() {
        
        self.dismiss(animated: false)
        
        let mapDetailViewController = MapDetailViewController()
        
        mapDetailViewController.closure = {self.presentBottomSheet()}
        
        mapDetailViewController.modalPresentationStyle = .pageSheet
        
        self.present(mapDetailViewController, animated: true)
        
    }
    
    func presentBottomSheet() {
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

    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        
        annotationClick()
        
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
            let subtitleLabel = UILabel()
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
            let miniButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            miniButton.setImage(UIImage(systemName: "person"), for: .normal)
            miniButton.tintColor = .blue
            annotationView?.rightCalloutAccessoryView = miniButton
            
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

}
