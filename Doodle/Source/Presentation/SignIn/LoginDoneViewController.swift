// 로그인완료 페이지

import UIKit

class LoginDoneViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 203/255, blue: 71/255, alpha: 1.0) // FFCB47
    }
}

// 비밀번호 보이기, 안보이기 표시버튼

// func textFieldDidBeginEditing(_ textField: UITextField) {
//    if textField == emailTextField {
//        emailTextFieldView.backgroundColor = .black
//        emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
//        // 오토레이아웃 업데이트
//        emailInfoLabelCenterYConstraint.constant = -13
//    }
//
//    if textField == passwordTextField {
//        passwordTextFieldView.backgroundColor = .black
//        passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
//        // 오토레이아웃 업데이트
//        passwordInfoLabelCenterYConstraint.constant = -13
//    }
//
//    // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
//    UIView.animate(withDuration: 0.3) {
//        self.stackView.layoutIfNeeded()
//    }
// }
