
import UIKit
import SnapKit
import Then

class CustomButton: UIButton {
    
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
    
    private func setShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.25
        clipsToBounds = true
        layer.masksToBounds = false
        
    }
    
    private func buttonStyle(){
        setTitleColor(.white, for: .normal)
        setTitle("", for: .normal)
        
        backgroundColor = UIColor(red: 0.996, green: 0.816, blue: 0.349, alpha: 1)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        layer.cornerRadius = 25
        
    }
    
    
    func setText(_ text:String){
        setTitle(text, for: .normal)
    }
    
    func setTheme(){
        setTitleColor(.black, for: .normal)
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func shake(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 3, y:center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 3, y:center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
}













#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct btnPreview: PreviewProvider{
    static var previews: some View {
        UIViewPreview {
            let view = CustomButton()
            
            return view
        }.previewLayout(.sizeThatFits)
    }
}
#endif

