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
    private lazy var topStackView = UIStackView().then({
        
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
        
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.spacing = 16
        $0.addArrangedSubview(strokeWeightSegmentedControl)
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
    
    private lazy var strokeWeights: [CGFloat] = [3.0, 5.0, 7.0]
    private lazy var strokeWeightSegmentedControl = UISegmentedControl(items: ["Regular", "Medium", "Bold"]).then({
        $0.selectedSegmentIndex = 0
        
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
        
        view.addSubViews([topStackView,
                          canvasView,
                          bottomStackView,
                          submitButton])
        
    }
    
    
    func setLayout() {
        
        topStackView.snp.makeConstraints { constraint in
            constraint.bottomMargin.equalTo(canvasView.snp.top)
            constraint.trailingMargin.equalToSuperview()
            constraint.height.equalTo(canvasView).multipliedBy(0.2)
        }
        
        canvasView.snp.makeConstraints { constraint in
            constraint.center.equalToSuperview()
            constraint.leading.trailing.equalToSuperview()
            constraint.height.equalTo(361)
        }
        
        bottomStackView.snp.makeConstraints{ constraint in
            constraint.top.equalTo(canvasView.snp.bottom).offset(16)
            constraint.leading.trailing.equalToSuperview().inset(16)
            constraint.bottomMargin.equalTo(submitButton.snp.top)
        }
        
        colorCollectionView.snp.makeConstraints { constraint in
            constraint.centerY.equalToSuperview()
            constraint.width.equalToSuperview().multipliedBy(0.7)
            constraint.height.equalToSuperview().multipliedBy(0.5)
        }
        
        strokeWeightSegmentedControl.snp.makeConstraints { constraint in
            constraint.centerY.equalToSuperview()
            constraint.bottom.equalTo(submitButton.snp.top)
            constraint.height.equalTo(colorCollectionView.snp.height)
        }
        
        submitButton.snp.makeConstraints { constraint in
            constraint.leading.equalTo(16)
            constraint.trailing.equalTo(-16)
            constraint.top.equalTo(canvasView.snp.bottom).offset(142)
            constraint.bottom.equalToSuperview().inset(16)
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
        
        strokeWeightSegmentedControl.addTarget(self, action: #selector(strokeWeightButtonTapped(_:)), for: .valueChanged)
        
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
    
    @objc func strokeWeightButtonTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                canvasView.defaultStrokeWeight = 3.0
            case 1:
                canvasView.defaultStrokeWeight = 5.0
            case 2:
                canvasView.defaultStrokeWeight = 7.0
            default:
                break
        }
    }
    
}

extension CreateDoodleViewController {
    
    private func regularMenu(_ action: UIAction) {
        canvasView.defaultStrokeWeight = CGFloat(3)
    }
    
    private func mediumMenu(_ action: UIAction) {
        canvasView.defaultStrokeWeight = CGFloat(5)
    }
    
    private func boldMenu(_ action: UIAction) {
        canvasView.defaultStrokeWeight = CGFloat(7)
    }
    
}

extension CreateDoodleViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        
        let selectedColor = viewController.selectedColor
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
            let color = UIColor(cgColor: canvasView.colors[indexPath.row])
            cell.configure(color: color)
        }
        return colorCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        canvasView.defaultStrokeColor = UIColor(cgColor: canvasView.colors[indexPath.row])
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

