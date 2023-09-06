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
        $0.addArrangedSubview(colorButton)
        $0.addArrangedSubview(colorCollectionView)
        
    })
    
    private let flowLayout = UICollectionViewFlowLayout().then({
        
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = CGFloat(8)
        $0.itemSize = CGSize(width: 50, height: 50)
        
    })
    
    private lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then({
        
        $0.register(ColorCell.self, forCellWithReuseIdentifier: "ColorCell")
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        
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
                          bottomStackView,
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
        
        bottomStackView.snp.makeConstraints{ constraint in
            constraint.top.equalTo(canvasView.snp.bottom).offset(16)
            constraint.leading.trailing.equalToSuperview().inset(16)
            constraint.height.equalTo(60)
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
    
    func setDelegate() {
        
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
    }
    
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
        
        canvasView.undo()
        print("Bezier path was undo before path")
        
    }
    
    @objc func redoButtonTapped(_ button: UIButton) {
        
        canvasView.redo()
        print("Bezier path was undo restored")
        
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

extension CreateDoodleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return canvasView.colors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let colorCell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath)
        if let cell = colorCell as? ColorCell {
            let color = canvasView.colors[indexPath.row]
            cell.configure(color: color)
        }
        return colorCell
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

#if DEBUG && canImport(SwiftUI)
import SwiftUI
private struct UIViewControllerRepresenter: UIViewControllerRepresentable {
    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct UIViewControllerPreviewView: PreviewProvider {
    static var previews: some View {
        let viewController = CreateDoodleViewController()
        return UIViewControllerRepresenter(viewController: viewController)
    }
}
#endif

