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
    private lazy var canvasView = CanvasView().then({
        
        $0.backgroundColor = .systemGray4
        
    })
    
    private lazy var stackView = UIStackView().then({
        
        $0.axis = .horizontal
        
    })
    
    private lazy var cancelButton = UIButton().then({
        
        $0.setTitle("취소", for: .normal)
        
    })
    
    private lazy var submitButton = UIButton().then({
        
        $0.setTitle("등록", for: .normal)
        
    })
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Doodle 만들기"
        
        view.backgroundColor = .blue
        
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
        view.addSubview(canvasView)
        
    }
    
    func setLayout() {
        
        canvasView.snp.makeConstraints { constraint in
            constraint.center.equalToSuperview()
            constraint.leading.trailing.equalToSuperview()
            constraint.height.equalTo(361)
        }
        
    }
    
    func setDelegate() {}
    
    func addTarget() {
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        
    }
    
}

extension CreateDoodleViewController {
    
    @objc func cancelButtonTapped(_ button: UIButton) {
        
        print("cancelButtonTapped")
        
    }
    
    @objc func submitButtonTapped(_ button: UIButton) {
        
        print("submitButtonTapped")
        
    }
    
}
