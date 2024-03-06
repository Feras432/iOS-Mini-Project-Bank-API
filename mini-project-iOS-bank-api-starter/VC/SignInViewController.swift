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
        <<< TextRow() { row in
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
        
    }
    
}
