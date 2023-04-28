//
//  ViewController.swift
//  SaveImageIntoDevice
//
//  Created by 임재현 on 2023/04/28.
//

import UIKit

class ViewController: UIViewController {
    
    var testImage:UIImage? {
        didSet{print("hi")
            conditionImageView.image = testImage
        }
    }
    
    
    lazy var conditionImageView:UIImageView = {
        var iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "어쩌라고")
        
        return iv
        
    }()
    
    lazy var angryImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "화남")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageView1Tapped))
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    lazy var calmImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "평온")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageView2Tapped))
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
   lazy var happyImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "행복")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageView3Tapped))
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let defaultimage:UIImage = #imageLiteral(resourceName: "어쩌라고")
    
    private let savedButton:UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(savedButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private let  deleteButton:UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    private let getSavedButton:UIButton = {
        let button = UIButton()
        button.setTitle("불러오기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(getSavedButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    let uniqueFileName:String = "happy"
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configUI()
        
    }

    func configUI() {
        view.addSubview(conditionImageView)
        conditionImageView.centerX(inView: view)
        conditionImageView.centerY(inView: view)
        conditionImageView.setDimensions(width: 400, height: 400)
        
        view.addSubview(savedButton)
        savedButton.anchor(left: view.leftAnchor,bottom: view.bottomAnchor,paddingLeft: 40,paddingBottom: 60)
        
        view.addSubview(getSavedButton)
        getSavedButton.centerY(inView: savedButton)
        getSavedButton.centerX(inView: conditionImageView)
        
        view.addSubview(deleteButton)
        deleteButton.centerY(inView: getSavedButton,leftAnchor: getSavedButton.rightAnchor,paddingLeft: 70)
        
        let stack = UIStackView(arrangedSubviews: [angryImageView,calmImageView,happyImageView])
        stack.axis = .horizontal
        stack.spacing = 10
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 30,paddingLeft: 40,paddingRight: 40)
        
        
    }
    
    // testImage를 device에 저장
    @objc func savedButtonTapped(){
        ImageFileManager.shared.saveImage(image: testImage ?? defaultimage, name: uniqueFileName) { [weak self]onSuccess in
            print("saveImage onSuccess \(onSuccess)")
        }
    }
    
    //저장된 testImage를 불러와서 imageview.image에 할당
    @objc func getSavedButtonTapped(){
        if let conditionImage:UIImage = ImageFileManager.shared.getSavedImage(named: uniqueFileName) {
            conditionImageView.image = conditionImage
        }
    }
    
    //저장되있던 testImage 삭제
    @objc func deleteButtonTapped(){
        ImageFileManager.shared.deleteImage(named: uniqueFileName) { onSuccess in
            print("delete =\(onSuccess)")
            self.testImage = self.defaultimage
        }
    }
    
    @objc func imageView1Tapped(){
        testImage = angryImageView.image
    }
    @objc func imageView2Tapped(){
        testImage = calmImageView.image
    }
    @objc func imageView3Tapped(){
        testImage = happyImageView.image
    }
}

