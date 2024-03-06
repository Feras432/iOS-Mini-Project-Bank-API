//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Feras Alshadad on 06/03/2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    var token : String?
    var amount : AmountChange?
        
    let nameLabelView = UILabel()
    let amountLabelView = UILabel()
    let depositButton = UIButton()
    let withdrawalButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(nameLabelView)
        view.addSubview(amountLabelView)
        view.addSubview(depositButton)
        view.addSubview(withdrawalButton)
        
        title = "Profile"
        setupUI()
        setupConstraints()
        
    }
    
    
    func setupUI(){
        depositButton.setTitle("Deposit", for: .normal)
        depositButton.backgroundColor = .green
        depositButton.layer.cornerRadius = 10
        
        
        withdrawalButton.setTitle("Withdrawal", for: .normal)
        withdrawalButton.backgroundColor = .red
        withdrawalButton.layer.cornerRadius = 10
    }
    
    func setupConstraints(){
        depositButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        withdrawalButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.trailing.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }

}
