//
//  SignUpViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Feras Alshadad on 06/03/2024.
//

import UIKit
import Eureka
class SignUpViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupForm()
    }
    
    func setupForm(){
        form +++ Section("Sign In")
        <<< TextRow() { row in
            row.title = "Username"
            row.placeholder = "Enter the username"
            row.tag = "username"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
            row.cellUpdate{ cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< EmailRow() { row in
            row.title = "Email"
            row.placeholder = "Enter the email"
            row.tag = "email"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
            row.cellUpdate{ cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< PasswordRow() { row in
            row.title = "Password"
            row.placeholder = "Enter the password"
            row.tag = "password"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            
            row.cellUpdate{ cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< ButtonRow(){ row in
            row.title = "Submit"
            row.onCellSelection{ cell , row in
                print("tapped")
                //self.submitTapped()
            }
        
        }
        
    }
    @objc func submitTapped(){
        let errors = form.validate()
        
        guard errors.isEmpty else{
            print(errors)
            presentAlertWithTitle(title: "🚨", message: "Some Text Fields is Empty!!!")
            return
        }
        let userNameRow: TextRow? = form.rowBy(tag: "username")
        let emailRow: EmailRow? = form.rowBy(tag: "email")
        let passwordRow: PasswordRow? = form.rowBy(tag: "password")
        
        let username = userNameRow?.value ?? ""
        let email = emailRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        
        let user = User(username: username, email: email, password: password)
        
        NetworkManager.shared.signup(user: user,completion: ){ success in
            
            DispatchQueue.main.async{
                if success {
                    print("success")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("failed")
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
