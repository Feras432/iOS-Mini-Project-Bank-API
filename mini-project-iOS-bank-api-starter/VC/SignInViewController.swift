//
//  SignInViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Feras Alshadad on 06/03/2024.
//

import UIKit
import Eureka
class SignInViewController: FormViewController {
    override func viewDidLoad() {
            super.viewDidLoad()

            setupForm()
        }

        private func setupForm() {
            form +++ Section()
                <<< TextRow() { row in
                    row.title = "Username"
                    row.placeholder = "Enter username"
                    row.tag = SignUpViewController.TagUser.username.rawValue
                    row.add(rule: RuleRequired())
                    row.validationOptions = .validatesOnChange
                    row.cellUpdate { cell, row in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                    }
                }
                <<< PasswordRow() { row in
                    row.title = "Password"
                    row.placeholder = "Enter password"
                    row.tag = SignUpViewController.TagUser.password.rawValue
                    row.add(rule: RuleRequired())
                    row.validationOptions = .validatesOnChange
                    row.cellUpdate { cell, row in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
                    }
                }
                +++ Section()
                <<< ButtonRow() { row in
                    row.title = "Sign In"
                    row.onCellSelection {cell,  row in
                        self.signInAction()
                    }
                }
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(signInAction))
       

        }
    
//    @objc func navigateButtonTapped() {
//        let secondVC = ProfileViewController()
//        secondVC.modalPresentationStyle = .fullScreen
//        
//        self.present(secondVC, animated: true, completion: nil)
//        // self.navigaitoncotnroller.push
//        
//    }
        @objc func signInAction() {
            let errors = form.validate()
            guard errors.isEmpty else {
                print("Error, something is missing! 😡")
                presentAlertWithTitle(title: "Error", message: "Something is missing!")
                return
            }

            let userNameRow: TextRow? = form.rowBy(tag: SignUpViewController.TagUser.username.rawValue)
            let passwordRow: PasswordRow? = form.rowBy(tag: SignUpViewController.TagUser.password.rawValue)

            let username = userNameRow?.value ?? ""
            let password = passwordRow?.value ?? ""

     
            NetworkManager.shared.signin(username: username, password: password) { success in
                DispatchQueue.main.async {
                    switch success {
                    case .success(let tokenResponse):
                        print("Sign In successful. Token: \(tokenResponse.token)")
                        
                        let ProfileVC = ProfileViewController()
                        ProfileVC.token = tokenResponse.token
                        self.navigationController?.pushViewController(ProfileVC, animated: true)
                        
                    case .failure(let error):
                        print("Sign In failed. Error: \(error.localizedDescription)")
                        
                    }
                }
            }
        }

        private func presentAlertWithTitle(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
}
