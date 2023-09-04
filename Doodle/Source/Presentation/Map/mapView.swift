import Foundation
import MapKit
import Then
import SnapKit

class MapViewController: UIViewController {
    
    lazy var mapView = MKMapView().then {
        $0.showsUserLocation = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    
        
        view.backgroundColor = UIColor.green
    }
}
