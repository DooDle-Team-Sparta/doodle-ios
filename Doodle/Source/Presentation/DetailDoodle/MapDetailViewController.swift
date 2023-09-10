import UIKit
import SnapKit

class MapDetailViewController: UIViewController {
    
    let mapDetailView = MapDetailView()
    
    var closure = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        mapDetailView.bottomCancelButton.addTarget(self, action: #selector(clickCancleBtn), for: .touchUpInside)
    }
    
    
    override func loadView() {
        view = mapDetailView
    }
    
    @objc func clickCancleBtn(){
        let BottomViewController = BottomViewController()
        self.dismiss(animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.closure()
    }
}
