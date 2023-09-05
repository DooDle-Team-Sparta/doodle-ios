//
//  CreateDoodleViewController.swift
//  Doodle
//
//  Created by Yujin Kim on 2023-09-04.
//

import SnapKit
import Then
import UIKit

class CreateDoodleViewController: UIViewController {
    
    //MARK: - UI
    private lazy var stackView = UIStackView().then({
        
        $0.axis = .horizontal
        $0.spacing = 16
        $0.addArrangedSubview(undoButton)
        $0.addArrangedSubview(redoButton)
        $0.addArrangedSubview(clearButton)
        
    })
    
    private lazy var undoButton = UIButton().then({
        
        $0.tintColor = .black
        $0.setImage(.undoImage, for: .normal)
        
    })
    
    private lazy var redoButton = UIButton().then({
        
        $0.tintColor = .black
        $0.setImage(.redoImage, for: .normal)
        
    })
    
    private lazy var clearButton = UIButton().then({
        
        $0.tintColor = .black
        $0.setImage(.clearImage, for: .normal)
        
    })
    
    private lazy var canvasView = CanvasView().then({
        
        $0.layer.borderWidth = CGFloat(1.0)
        $0.layer.borderColor = UIColor(hex: "#DDDDDD").cgColor
        $0.backgroundColor = UIColor(hex: "#FFFFFF")
        
    })
    
    private lazy var bottomStackView = UIStackView().then({
        
        $0.axis = .horizontal
        $0.spacing = 16
        
    })
    
    private var selectedColor: UIColor = .black
    private lazy var colorButton = UIButton().then({
        
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        
    })
    
    private lazy var submitButton = UIButton().then({
        
        $0.layer.cornerRadius = CGFloat(8)
        $0.titleLabel?.textAlignment = .center
        $0.backgroundColor = UIColor(hex: "#FFCB47")
        $0.setTitleColor(UIColor(hex: "#141617"), for: .normal)
        $0.setTitle("등록", for: .normal)
        
    })
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Doodle 만들기"
        view.backgroundColor = .white
        setUI()
        setLayout()
        setDelegate()
        addTarget()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
    }
    
    //MARK: - Custom 메소드
    func setUI() {
        
        view.addSubViews([stackView,
                          canvasView,
                          colorButton,
                          submitButton])
        
    }
    
    
    func setLayout() {
        
        stackView.snp.makeConstraints { constraint in
            constraint.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            constraint.bottom.equalTo(canvasView.snp.top).offset(16)
            constraint.trailingMargin.equalToSuperview()
        }
        
        canvasView.snp.makeConstraints { constraint in
            constraint.center.equalToSuperview()
            constraint.leading.trailing.equalToSuperview()
            constraint.height.equalTo(361)
        }
        
        colorButton.snp.makeConstraints { constraint in
            constraint.top.equalTo(canvasView.snp.bottom).offset(16)
            constraint.leadingMargin.equalToSuperview()
            constraint.bottom.equalTo(submitButton.snp.top).offset(16)
        }
        
        submitButton.snp.makeConstraints { constraint in
            constraint.top.equalTo(canvasView.snp.bottom).offset(142)
            constraint.leading.equalTo(16)
            constraint.trailing.equalTo(-16)
            constraint.height.equalTo(60)
        }
        
    }
    
    func setDelegate() {}
    
    func addTarget() {
        
        undoButton.addTarget(self, action: #selector(undoButtonTapped(_:)), for: .touchUpInside)
        
        redoButton.addTarget(self, action: #selector(redoButtonTapped(_:)), for: .touchUpInside)
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        
        colorButton.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        
    }
    
}

extension CreateDoodleViewController {
    
    @objc func undoButtonTapped(_ button: UIButton) {
        
        print("undoButtonTapped")
        
    }
    
    @objc func redoButtonTapped(_ button: UIButton) {
        
        print("redoButtonTapped")
        
    }
    
    @objc func clearButtonTapped(_ button: UIButton) {
        
        canvasView.clear()
        print("Bezier path was deleted")
        
    }
    
    @objc func submitButtonTapped(_ button: UIButton) {
        
        print("submitButtonTapped")
        
    }
    
    @objc func colorButtonTapped(_ button: UIButton) {
        
        print("colorButtonTapped")
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: true, completion: nil)
        
    }
    
}

extension CreateDoodleViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        
        let selectedColor = viewController.selectedColor
        self.selectedColor = selectedColor
        canvasView.defaultStrokeColor = selectedColor
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        
        var hexFormat: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if hexFormat.hasPrefix("#") {
            
            hexFormat = String(hexFormat.dropFirst())
            
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexFormat).scanHexInt64(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: alpha)
        
    }
}

extension UIImage {
    
    static let undoImage = UIImage(systemName: "arrow.counterclockwise.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
    static let redoImage = UIImage(systemName: "arrow.clockwise.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
    static let clearImage = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    
}
