//
//  WithdrawViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Mubarak Aloraifan on 06/03/2024.
//

import UIKit
import Eureka
import SnapKit

class WithdrawViewController: FormViewController {
    
    var token : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WithdrawDetUp()
        submitTapped()
    }
    

    func WithdrawDetUp(){
        form +++ Section("Withdraw")
        <<< DecimalRow(){ row in
            
            row.title = "Enter Withdraw Value"
            row.placeholder = "Value"
            row.tag = "Withdraw"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< ButtonRow(){ row in
            row.title = "Withdraw"
            row.tag = "Withdrawclick"
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
        let withdrawRow: DecimalRow? = form.rowBy(tag: "withdraw")
        
        let withdraw = withdrawRow?.value ?? 0.0
        let amount = AmountChange(amount: withdraw)
        
        NetworkManager.shared.withdraw(token: token!, amountChange: amount) { result in
            
            switch result {
            case .success(_):
                print("Withdrawal is done!")
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
