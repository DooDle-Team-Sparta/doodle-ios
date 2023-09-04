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
    })
    
    private lazy var cancelButton = UIButton().then({
        $0.setTitle("취소", for: .normal)
    })
    
    private lazy var submitButton = UIButton().then({
        $0.setTitle("등록", for: .normal)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        view.addSubview(stackView)
        stackView.addSubViews([cancelButton,
                               submitButton])
        
    }
    
    func setLayout() {
        
        stackView.snp.makeConstraints { constraint in
            constraint.center.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { constraint in
            constraint.leading.equalTo(stackView.snp.leading)
        }
        
        submitButton.snp.makeConstraints { constraint in
            constraint.trailing.equalTo(stackView.snp.trailing)
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
