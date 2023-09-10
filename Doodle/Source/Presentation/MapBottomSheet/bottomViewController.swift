//
//  BottomViewController.swift
//  Doodle
//
//  Created by Oong2 on 2023/09/04.
//  Edited by yujinkim1 on 2023/09/09.

import SwiftUI
import SnapKit
import Then
import MapKit
import UIKit

//class tableViewCell: UITableViewCell{
//    static let reuseIdentifier = "Cell"
//}
let defaults = UserDefaults.standard


class PointClass{

    var price: Int

    init(price: Int) {
        self.price = price
    }

}

class BottomViewController: UIViewController,UITableViewDelegate{
    
    let pointAll = PointClass(price: 0)
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configureDoodleTableViewCell()
//    }
    
//    required init? (coder: NSCoder){
//        fatalError("init(coder:) has not been implemented")
//    }
    
    let headerImage : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "doodlelogo")
        return view
    }()
    let addBtn : UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "addPlus"), for: .normal)
        return view
    }()
    let doodlePoint : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 355, height: 50)
        view.layer.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1).cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    let doodlePointLabel : UILabel = {
        let view = UILabel()
        view.text = "두들 포인트"
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textAlignment = .left
        return view
    }()
    lazy var doodlePointLabel2 : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.text = "0 P"
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textAlignment = .center
        return view
    }()
    let doodleStatus : UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 1, green: 0.891, blue: 0.613, alpha: 1).cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    let doodleStatusNoLog : UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.4, green: 0.891, blue: 0.613, alpha: 1).cgColor
        view.layer.cornerRadius = 5
        view.isHidden = true
        return view
    }()
    let doodleStatusHeader : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "doodlelogoWhite")
        view.isHidden = true
        return view
    }()
    let doodleStatusNoLogMes : UILabel = {
        let view = UILabel()
        view.text = "로그인이 필요합니다"
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.isHidden = true
        return view
    }()
    let statusLabel : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.06
        view.attributedText = NSMutableAttributedString(string: "김기호 님이 \n열심히 낙서한 현황", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle:paragraphStyle])
//        이름 정보 받아와야함
        view.textAlignment = .left
        return view
    }()
    let statusImage : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "statusTest")   //이미지 정보 받아와야 함, 그림자 추가 해야 함
        view.frame = view.frame
        view.clipsToBounds = true
        view.layer.cornerRadius = 23
        view.isUserInteractionEnabled = true
        return view
    }()
    let statusImageShadow : UIButton = {
        let view = UIButton()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        view.layer.shadowOpacity = 0.6
        view.backgroundColor = .white
        view.layer.cornerRadius = 23
        return view
    }()
    let statusTier : UILabel = {
        let view = UILabel()
        view.text = "BRONZE 등급" // 티어 입력값 받아야함
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textAlignment = .left
        return view
    }()
    let tierProgressView : UIProgressView = {
        let view = UIProgressView()
        view.progressViewStyle = .default
        view.progressTintColor = UIColor(red: 1, green: 0.745, blue: 0.094, alpha: 1)
        view.transform = view.transform.scaledBy(x: 1, y: 2)
        view.setProgress(0, animated: true)
        return view
    }()
    let doodlePointResult : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textAlignment = .center
        var paragraphStyle = NSMutableParagraphStyle()
        view.attributedText = NSMutableAttributedString(string: "0 / 300 P", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return view
    }()
    let locateLabel : UILabel = {
        let view = UILabel()
        view.text = "실시간 내 주변 DooDle"
        view.textColor = UIColor(red: 0.213, green: 0.213, blue: 0.213, alpha: 1)
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.textAlignment = .left
        return view
    }()
    let doodleTableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureAll()
        doodleTableView.dataSource = self
        doodleTableView.delegate = self
        doodleTableView.register(NowCell.self, forCellReuseIdentifier: "Cell")
//        defaults.setValue("\(+5)", forKey: "doodlePointPlus")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(StatusImageClick(_:)))
        statusImage.addGestureRecognizer(tapGesture)
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)

    }
    
    @objc func StatusImageClick(_ gesture: UITapGestureRecognizer){
        let myPageViewController = MyPageViewController()
//        self.navigationController?.pushViewController(myPageViewController, animated: true)
        myPageViewController.modalPresentationStyle = .overCurrentContext
        self.present(myPageViewController, animated: true)
    }
    @objc func addBtnClick(){
        let CreateDoodleViewController = CreateDoodleViewController()
//        self.navigationController?.pushViewController(CreateDoodleViewController, animated: true)
        self.present(CreateDoodleViewController, animated: true)
        pointAll.price += 30
        doodlePointLabel2.text = "\(pointAll.price) P"
        var paragraphStyle = NSMutableParagraphStyle()
        doodlePointResult.attributedText = NSMutableAttributedString(string: "\(pointAll.price) / 300 P", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        tierProgressView.progress += 0.1
        if tierProgressView.progress == 1 {
            statusTier.text = "등급 업 가능!"
            
        }
    }
//
//    func setLabel(){
//        doodlePointLabel2.text = "\(pointAll.price) P"
//    }
    
    func configureAll(){
        configureHeader()
        cogHeader()
        configureDoodlePoint()
        configureDoodlePointLabel()
        configureDoodlePointLabel2()
        configureDoodleStatus()
        configureStatusLabel()
        configureStatusImageShadow()
        configureStatusImage()
        configureStatusTier()
        configureDoodleResult()
        configureProgress()
        configureLocateLabel()
        configureDoodleTableView()
        configureDoodleStatusNoLog()
        configureDoodleStatusHeader()
        configureDoodleStatusNoLogMes()
    }
    
    func configureHeader(){
        self.view.addSubview(headerImage)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: view.topAnchor , constant: 35),
            headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20)
        ])
    }
    func cogHeader(){
        self.view.addSubview(addBtn)
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addBtn.topAnchor.constraint(equalTo: view.topAnchor , constant: 48),
            addBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 350)
        ])
    }
    func configureDoodlePoint(){
        self.view.addSubview(doodlePoint)
        doodlePoint.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodlePoint.topAnchor.constraint(equalTo: headerImage.bottomAnchor , constant: 20),
            doodlePoint.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 19),
            doodlePoint.widthAnchor.constraint(equalToConstant: 355),
            doodlePoint.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureDoodlePointLabel(){
        self.view.addSubview(doodlePointLabel)
        doodlePointLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodlePointLabel.topAnchor.constraint(equalTo: doodlePoint.topAnchor , constant: 0),
            doodlePointLabel.leadingAnchor.constraint(equalTo: doodlePoint.leadingAnchor , constant: 18),
            doodlePointLabel.widthAnchor.constraint(equalToConstant: 60),
            doodlePointLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureDoodlePointLabel2(){
        self.view.addSubview(doodlePointLabel2)
        doodlePointLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodlePointLabel2.topAnchor.constraint(equalTo: doodlePoint.topAnchor , constant: 0),
            doodlePointLabel2.leadingAnchor.constraint(equalTo: doodlePointLabel.trailingAnchor , constant: 0),
            doodlePointLabel2.widthAnchor.constraint(equalToConstant: 40),
            doodlePointLabel2.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureDoodleStatus(){
        self.view.addSubview(doodleStatus)
        doodleStatus.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodleStatus.topAnchor.constraint(equalTo: doodlePoint.bottomAnchor , constant: 20),
            doodleStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 19),
            doodleStatus.widthAnchor.constraint(equalToConstant: 355),
            doodleStatus.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    func configureDoodleStatusNoLog(){
        self.view.addSubview(doodleStatusNoLog)
        doodleStatusNoLog.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodleStatusNoLog.topAnchor.constraint(equalTo: doodlePoint.bottomAnchor , constant: 20),
            doodleStatusNoLog.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 19),
            doodleStatusNoLog.widthAnchor.constraint(equalToConstant: 355),
            doodleStatusNoLog.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    func configureDoodleStatusHeader(){
        self.view.addSubview(doodleStatusHeader)
        doodleStatusHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodleStatusHeader.topAnchor.constraint(equalTo: doodleStatusNoLog.topAnchor , constant: 10),
            doodleStatusHeader.leadingAnchor.constraint(equalTo: doodleStatusNoLog.leadingAnchor , constant: 20),
            doodleStatusNoLog.widthAnchor.constraint(equalToConstant: 120),
            doodleStatusNoLog.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func configureDoodleStatusNoLogMes(){
        self.view.addSubview(doodleStatusNoLogMes)
        doodleStatusNoLogMes.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodleStatusNoLogMes.bottomAnchor.constraint(equalTo: doodleStatusNoLog.bottomAnchor , constant: -30),
            doodleStatusNoLogMes.trailingAnchor.constraint(equalTo: doodleStatusNoLog.trailingAnchor , constant: -20),
            doodleStatusNoLogMes.widthAnchor.constraint(equalToConstant: 140),
            doodleStatusNoLogMes.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureStatusLabel(){
        self.view.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: doodleStatus.topAnchor , constant: 18),
            statusLabel.leadingAnchor.constraint(equalTo: doodleStatus.leadingAnchor , constant: 18),
            statusLabel.widthAnchor.constraint(equalToConstant: 120),
            statusLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    func configureStatusImage(){
        self.view.addSubview(statusImage)
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusImage.topAnchor.constraint(equalTo: doodleStatus.topAnchor , constant: 18),
            statusImage.trailingAnchor.constraint(equalTo: doodleStatus.trailingAnchor , constant: -18),
            statusImage.widthAnchor.constraint(equalToConstant: 46),
            statusImage.heightAnchor.constraint(equalToConstant: 46),
        ])
    }
    func configureStatusImageShadow(){
        self.view.addSubview(statusImageShadow)
        statusImageShadow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusImageShadow.topAnchor.constraint(equalTo: doodleStatus.topAnchor , constant: 18),
            statusImageShadow.trailingAnchor.constraint(equalTo: doodleStatus.trailingAnchor , constant: -18),
            statusImageShadow.widthAnchor.constraint(equalToConstant: 46),
            statusImageShadow.heightAnchor.constraint(equalToConstant: 46),
        ])
    }
    func configureStatusTier(){
        self.view.addSubview(statusTier)
        statusTier.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusTier.bottomAnchor.constraint(equalTo: doodleStatus.bottomAnchor , constant: -36),
            statusTier.leadingAnchor.constraint(equalTo: doodleStatus.leadingAnchor , constant: 18),
            statusTier.widthAnchor.constraint(equalToConstant: 100),
            statusTier.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    func configureProgress(){
        self.view.addSubview(tierProgressView)
        tierProgressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tierProgressView.topAnchor.constraint(equalTo: statusTier.bottomAnchor, constant: 6),
            tierProgressView.leadingAnchor.constraint(equalTo: doodleStatus.leadingAnchor, constant: 18),
            tierProgressView.widthAnchor.constraint(equalToConstant: 240),
        ])
    }
    func configureDoodleResult(){
        self.view.addSubview(doodlePointResult)
        doodlePointResult.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodlePointResult.topAnchor.constraint(equalTo: statusImage.bottomAnchor , constant: 18),
            doodlePointResult.leadingAnchor.constraint(equalTo: doodleStatus.leadingAnchor , constant: 280),
            doodlePointResult.widthAnchor.constraint(equalToConstant: 66),
            doodlePointResult.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    func configureLocateLabel(){
        self.view.addSubview(locateLabel)
        locateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locateLabel.topAnchor.constraint(equalTo: doodleStatus.bottomAnchor , constant: 20),
            locateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            locateLabel.widthAnchor.constraint(equalToConstant: 355),
            locateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    func configureDoodleTableView(){
        self.view.addSubview(doodleTableView)
        doodleTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doodleTableView.topAnchor.constraint(equalTo: locateLabel.bottomAnchor , constant: 8),
//            doodleTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: 0),
            doodleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
            doodleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20),
            doodleTableView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}

extension BottomViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NowCell
        //        cell.itemNameLabel.text = self.itemName[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
#if DEBUG

struct ViewControllerRepresentable: UIViewControllerRepresentable{
    
    //    update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        BottomViewController()
    }
    //    makeui
    
}


struct ViewController_Previews: PreviewProvider{
    static var previews: some View{
        ViewControllerRepresentable()
            .previewDisplayName("아이폰 14")
        
    }
}


#endif
