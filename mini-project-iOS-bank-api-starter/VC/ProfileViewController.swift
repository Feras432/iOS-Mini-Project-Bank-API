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
    //    var detailsOfProfile: ProfileDetails
    var transaction: [Transaction] = []
    
    let nameLabelView = UILabel()
    let emailLabelView = UILabel()
    let balanceLabelView = UILabel()
    let depositButton = UIButton()
    let withdrawalButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(nameLabelView)
        view.addSubview(emailLabelView)
        view.addSubview(depositButton)
        view.addSubview(balanceLabelView)
        view.addSubview(withdrawalButton)
        
        title = "Profile"
        setupUI()
        setupConstraints()
        fetchUser()
        transactionButton()
        
        func setupUI(){
            depositButton.setTitle("Deposit", for: .normal)
            depositButton.backgroundColor = .green
            depositButton.layer.cornerRadius = 10
            
            
            withdrawalButton.setTitle("Withdrawal", for: .normal)
            withdrawalButton.backgroundColor = .red
            withdrawalButton.layer.cornerRadius = 10
        }
        
        
         func transactionButton() {
            let navigationController = UINavigationController(rootViewController: TransactionListViewController())
            present(navigationController, animated: true, completion: nil)
        }
        
        
        func setupConstraints(){
            nameLabelView.snp.makeConstraints { make in
                make.bottom.equalTo(balanceLabelView.snp.top).offset(-10)
                make.leading.trailing.equalToSuperview()
                make.width.equalTo(100)
            }
            emailLabelView.snp.makeConstraints { make in
                make.bottom.equalTo(nameLabelView.snp.top).offset(-10)
                make.leading.trailing.equalToSuperview()
                make.width.equalTo(100)
            }
            balanceLabelView.snp.makeConstraints { make in
                make.bottom.equalTo(depositButton.snp.top).offset(-120)
                make.leading.trailing.equalToSuperview()
                make.width.equalTo(100)
            }
            
            
            depositButton.snp.makeConstraints { make in
                make.centerY.equalTo(withdrawalButton.snp.centerY).offset(10)
                make.width.equalTo(100)
                make.height.equalTo(50)
            }
            
            withdrawalButton.snp.makeConstraints { make in
                make.center.equalToSuperview().offset(10)
                make.width.equalTo(100)
                make.height.equalTo(50)
            }
        }
        
        func fetchUser() {
            NetworkManager.shared.fetchAccount(token: token!){ result in
                
                DispatchQueue.main.async {
                    
                    switch result {
                        
                    case .success(let details):
                        self.nameLabelView.text = details.username
                        self.emailLabelView.text = details.username
                        self.balanceLabelView.text = details.username
                        
                        print("\( details.username)")
                        print("\(details.email)")
                        print("\(details.balance)")
                        self.balanceLabelView.text = String(details.balance)
                        self.emailLabelView.text = details.email
                    case .failure(let error ):
                        print(error)
                        
                    }
                }
                
            }
        }
    }
}
