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
        view.backgroundColor = .white
        view.addSubview(signupButton)
        view.addSubview(signinButton)
        
        setupUI()
        setupConstraints()
        
        title = "Home"
        
        
        signinButton.addTarget(self, action: #selector(navigateButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(navigateButton), for: .touchUpInside)

        
        
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        signinButton.setTitle("Sign In", for: .normal)
        signinButton.backgroundColor = .black
        signinButton.layer.cornerRadius = 10
        
        
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.backgroundColor = .black
        signupButton.layer.cornerRadius = 10
        
        
        
        
        
    }
    @objc func navigateButtonTapped() {
        let secondVC = SignInViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)

    }
    
    @objc func navigateButton() {
        let thirdVC = SignUpViewController()
        self.navigationController?.pushViewController(thirdVC, animated: true)
        
    }
    func setupConstraints(){
        signinButton.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(signinButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
}

