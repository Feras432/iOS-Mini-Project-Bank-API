//
//  DepositViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Mubarak Aloraifan on 06/03/2024.
//

import UIKit
import Eureka
import SnapKit

class DepositViewController: FormViewController {
    
    var token : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        depositDetUp()
        submitTapped()
    }
    func depositDetUp(){
        form +++ Section("Deposit")
        <<< DecimalRow(){ row in
            
            row.title = "Enter Deposit Value"
            row.placeholder = "Value"
            row.tag = "deposit"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< ButtonRow(){ row in
            row.title = "Deposit"
            row.tag = "depositclick"
            row.onCellSelection{ cell , row in
                print("tapped")
                self.submitTapped()
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
        let depositRow: DecimalRow? = form.rowBy(tag: "deposit")
        
        let deposit = depositRow?.value ?? 0.0
        let amount = AmountChange(amount: deposit)
        
        NetworkManager.shared.deposit(token: token!, amountChange: amount) { result in
            
            switch result {
            case .success(_):
                print("Depost is done!")
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
         func presentAlertWithTitle(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
}
