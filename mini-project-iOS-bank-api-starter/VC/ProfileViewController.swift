//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Feras Alshadad on 06/03/2024.
//


import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    var token: String?
    var userDetails: ProfileDetails?

    let nameLabelView = UILabel()
    let emailLabelView = UILabel()
    let balanceLabelView = UILabel()
    let depositButton = UIButton()
    let withdrawalButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = "Profile"
        setupUI()
        setupConstraints()
        fetchUser()
        transactionButton()
        depositButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)
        withdrawalButton.addTarget(self, action: #selector(withdrawTapped), for: .touchUpInside)
    }

    func setupUI() {
        depositButton.setTitle("Deposit", for: .normal)
        depositButton.backgroundColor = .systemGreen
        depositButton.layer.cornerRadius = 10
        
        withdrawalButton.setTitle("Withdrawal", for: .normal)
        withdrawalButton.backgroundColor = .systemRed
        withdrawalButton.layer.cornerRadius = 10
    }
    
    func transactionButton(){
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "clock"), style: .plain, target: self, action: #selector(transactionList))
            navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        }

        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }


    @objc func transactionList() {
        
        let transactionVC = TransactionListViewController()
        
        transactionVC.token = token
        
        navigationController?.pushViewController(transactionVC, animated: true)
        
    }

        @objc func depositTapped(){
             let depositVC = DepositViewController()
            depositVC.modalPresentationStyle = .popover
            depositVC.token = token
             self.present(depositVC, animated: true)
         }
    
        @objc func withdrawTapped(){
             let withdrawVC = WithdrawViewController()
            withdrawVC.modalPresentationStyle = .popover
            withdrawVC.token = token
            self.present(withdrawVC, animated: true)

         }
    func setupConstraints() {
        view.addSubview(nameLabelView)
        view.addSubview(emailLabelView)
        view.addSubview(balanceLabelView)
        view.addSubview(depositButton)
        view.addSubview(withdrawalButton)

        nameLabelView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }

        emailLabelView.snp.makeConstraints { make in
            make.top.equalTo(nameLabelView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        balanceLabelView.snp.makeConstraints { make in
            make.top.equalTo(emailLabelView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        withdrawalButton.snp.makeConstraints { make in
            make.top.equalTo(balanceLabelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

        depositButton.snp.makeConstraints { make in
            make.top.equalTo(withdrawalButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }

    func fetchUser() {
        guard let token = token else { return }
        NetworkManager.shared.fetchAccount(token: token) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let details):
                    self.userDetails = details
                    self.updateUI()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func updateUI() {
        guard let userDetails = userDetails else { return }
        nameLabelView.text = "User Name: \(userDetails.username)"
        emailLabelView.text = "Password: \(userDetails.email)"
        balanceLabelView.text = "Balance: \(userDetails.balance)"
    }
}
