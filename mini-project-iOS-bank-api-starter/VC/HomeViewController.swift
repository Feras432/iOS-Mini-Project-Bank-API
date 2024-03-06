//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {
        
    let signupButton = UIButton()
    let signinButton = UIButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signupButton)
        view.addSubview(signinButton)
        
        setupUI()
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        signinButton.setTitle("Sign In", for: .normal)
        signinButton.backgroundColor = .green
        signinButton.layer.cornerRadius = 10
        
        
        signupButton.setTitle("Sign In", for: .normal)
        signupButton.backgroundColor = .blue
        signupButton.layer.cornerRadius = 10
        
        
    }
    func setupConstraints(){
        signinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}

