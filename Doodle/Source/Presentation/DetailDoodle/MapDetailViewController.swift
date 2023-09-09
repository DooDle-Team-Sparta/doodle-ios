import UIKit
import SnapKit

class MapDetailViewController: UIViewController {
    
    let mapDetailView = MapDetailView()
    
    var closure = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    
    override func loadView() {
        view = mapDetailView
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.closure()
    }
}
