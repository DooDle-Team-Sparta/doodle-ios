//
//  myPageViewController.swift
//  Doodle
//
//  Created by t2023-m0088 on 2023/09/04.
//

import UIKit
import SwiftUI
import SnapKit
import Then
import Alamofire



class myPageViewController: UIViewController {
    
    let myPageLabel : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 32)
        view.textAlignment = .left
        view.attributedText = NSMutableAttributedString(string: "마이 페이지", attributes: [NSAttributedString.Key.kern: -1.28])

        return view
    }()
    let myPageImage : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "statusTest")   //이미지 정보 받아와야 함, 그림자 추가 해야 함
        view.frame = view.frame
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    let myPageImageShadow : UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowOpacity = 0.6
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    let myPageNameLabel : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textAlignment = .left
        view.attributedText = NSMutableAttributedString(string: "김기호 님!", attributes: [NSAttributedString.Key.kern: -0.1])

        return view
    }()
    let myPageNumberLabel : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textAlignment = .left
        view.attributedText = NSMutableAttributedString(string: "010-0000-0000", attributes: [NSAttributedString.Key.kern: -0.1])

        return view
    }()
    let profileSetBtn : UIButton = {
        let view = UIButton()
        view.setTitle("프로필 설정", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemGray3
        return view
    }()
    let LogOutBtn : UIButton = {
        let view = UIButton()
        view.setTitle("로그아웃", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.layer.cornerRadius = 25
        view.backgroundColor = .systemGray3
        return view
    }()
    let setBtn1 : UIButton = {
        let view = UIButton()
        view.setTitle("계정관리", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.61), for: .normal)
        view.setBackgroundColor(.systemGray3, for: .highlighted)
        view.setTitleColor(.white, for: .highlighted)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    let setBtn2 : UIButton = {
        let view = UIButton()
        view.setTitle("개인/보안", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.61), for: .normal)
        view.setBackgroundColor(.systemGray3, for: .highlighted)
        view.setTitleColor(.white, for: .highlighted)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    let setBtn3 : UIButton = {
        let view = UIButton()
        view.setTitle("친구목록", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.61), for: .normal)
        view.setBackgroundColor(.systemGray3, for: .highlighted)
        view.setTitleColor(.white, for: .highlighted)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    let setBtn4 : UIButton = {
        let view = UIButton()
        view.setTitle("테마변경", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.61), for: .normal)
        view.setBackgroundColor(.systemGray3, for: .highlighted)
        view.setTitleColor(.white, for: .highlighted)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    let setBtn5 : UIButton = {
        let view = UIButton()
        view.setTitle("두들스타일", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.61), for: .normal)
        view.setBackgroundColor(.systemGray3, for: .highlighted)
        view.setTitleColor(.white, for: .highlighted)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    let setBtn6 : UIButton = {
        let view = UIButton()
        view.setTitle("두들포인트", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.61), for: .normal)
        view.setBackgroundColor(.systemGray3, for: .highlighted)
        view.setTitleColor(.white, for: .highlighted)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    let setBtn7 : UIButton = {
        let view = UIButton()
        view.setTitle("기타", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.61), for: .normal)
        view.setBackgroundColor(.systemGray3, for: .highlighted)
        view.setTitleColor(.white, for: .highlighted)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAll2()

    }
    

    func configureAll2(){
        configureMyPageLabel()
        configureMyPageImageShadow()
        configureMyPageImage()
        configureMyPageNameLabel()
        configureMyPageNumberLabel()
        configureProfileSet()
        configureLogOutBtn()
        configureSetBtn1()
        configureSetBtn2()
        configureSetBtn3()
        configureSetBtn4()
        configureSetBtn5()
        configureSetBtn6()
        configureSetBtn7()
    }

    func configureMyPageLabel(){
        self.view.addSubview(myPageLabel)
        myPageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myPageLabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 80),
            myPageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 30),
            myPageLabel.widthAnchor.constraint(equalToConstant: 150),
            myPageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureMyPageImage(){
        self.view.addSubview(myPageImage)
        myPageImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myPageImage.topAnchor.constraint(equalTo: myPageLabel.bottomAnchor , constant: 24),
            myPageImage.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 30),
            myPageImage.widthAnchor.constraint(equalToConstant: 60),
            myPageImage.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func configureMyPageImageShadow(){
        self.view.addSubview(myPageImageShadow)
        myPageImageShadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myPageImageShadow.topAnchor.constraint(equalTo: myPageLabel.bottomAnchor , constant: 24),
            myPageImageShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 30),
            myPageImageShadow.widthAnchor.constraint(equalToConstant: 60),
            myPageImageShadow.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func configureMyPageNameLabel(){
        self.view.addSubview(myPageNameLabel)
        myPageNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myPageNameLabel.topAnchor.constraint(equalTo: myPageLabel.bottomAnchor , constant: 34),
            myPageNameLabel.leadingAnchor.constraint(equalTo: myPageImage.trailingAnchor , constant: 12),
            myPageNameLabel.widthAnchor.constraint(equalToConstant: 100),
            myPageNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureMyPageNumberLabel(){
        self.view.addSubview(myPageNumberLabel)
        myPageNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myPageNumberLabel.topAnchor.constraint(equalTo: myPageNameLabel.bottomAnchor , constant: 4),
            myPageNumberLabel.leadingAnchor.constraint(equalTo: myPageImage.trailingAnchor , constant: 12),
            myPageNumberLabel.widthAnchor.constraint(equalToConstant: 120),
            myPageNumberLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    func configureProfileSet(){
        self.view.addSubview(profileSetBtn)
        profileSetBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileSetBtn.topAnchor.constraint(equalTo: myPageLabel.bottomAnchor , constant: 40),
            profileSetBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -30),
            profileSetBtn.widthAnchor.constraint(equalToConstant: 80),
            profileSetBtn.heightAnchor.constraint(equalToConstant: 30  )
        ])
    }
    func configureLogOutBtn(){
        self.view.addSubview(LogOutBtn)
        LogOutBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LogOutBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -72),
            LogOutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LogOutBtn.widthAnchor.constraint(equalToConstant: 160),
            LogOutBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureSetBtn1(){
        self.view.addSubview(setBtn1)
        setBtn1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBtn1.topAnchor.constraint(equalTo: myPageImage.bottomAnchor , constant: 34),
            setBtn1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            setBtn1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            setBtn1.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureSetBtn2(){
        self.view.addSubview(setBtn2)
        setBtn2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBtn2.topAnchor.constraint(equalTo: setBtn1.bottomAnchor , constant: 10),
            setBtn2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            setBtn2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            setBtn2.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureSetBtn3(){
        self.view.addSubview(setBtn3)
        setBtn3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBtn3.topAnchor.constraint(equalTo: setBtn2.bottomAnchor , constant: 10),
            setBtn3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            setBtn3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            setBtn3.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureSetBtn4(){
        self.view.addSubview(setBtn4)
        setBtn4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBtn4.topAnchor.constraint(equalTo: setBtn3.bottomAnchor , constant: 10),
            setBtn4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            setBtn4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            setBtn4.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureSetBtn5(){
        self.view.addSubview(setBtn5)
        setBtn5.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBtn5.topAnchor.constraint(equalTo: setBtn4.bottomAnchor , constant: 10),
            setBtn5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            setBtn5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            setBtn5.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureSetBtn6(){
        self.view.addSubview(setBtn6)
        setBtn6.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBtn6.topAnchor.constraint(equalTo: setBtn5.bottomAnchor , constant: 10),
            setBtn6.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            setBtn6.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            setBtn6.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureSetBtn7(){
        self.view.addSubview(setBtn7)
        setBtn7.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setBtn7.topAnchor.constraint(equalTo: setBtn6.bottomAnchor , constant: 10),
            setBtn7.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            setBtn7.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            setBtn7.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(backgroundImage, for: state)
        layer.cornerRadius = 5
    }
}

#if DEBUG

struct ViewControllerRepresentable1: UIViewControllerRepresentable{
    
    //    update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        myPageViewController()
    }
    //    makeui
    
}


struct ViewController_Previews1: PreviewProvider{
    static var previews: some View{
        ViewControllerRepresentable1()
            .previewDisplayName("아이폰 14")
        
    }
}


#endif
