import UIKit
import SnapKit
import Then

class CircleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buttonConfig()
    }
    
    
    
    private func buttonConfig(){
        setShadow()
        buttonStyle()
    }
    
    func setIcon(_ systemName:String){
        setImage(UIImage(systemName: systemName), for: .normal)

    }
    
    private func buttonStyle(){
        setTitleColor(.white, for: .normal)
        setImage(UIImage(systemName: "arrowshape.turn.up.forward.fill"), for: .normal)
        tintColor = .darkGray
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        layer.cornerRadius = 33
        
    }
    
    private func setShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.25
        clipsToBounds = true
        layer.masksToBounds = false
        
    }
    
    
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct cbtnPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = CircleButton()
            
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif

