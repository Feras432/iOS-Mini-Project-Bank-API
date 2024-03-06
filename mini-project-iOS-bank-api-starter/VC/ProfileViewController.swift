//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Feras Alshadad on 06/03/2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    var user : User?
    var amount : AmountChange?
    
    
    let nameLabelView = UILabel()
    let amountLabelView = UILabel()
    let depositButton = UIButton()
    let withdrawalButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(nameLabelView)
        view.addSubview(amountLabelView)
        view.addSubview(depositButton)
        view.addSubview(withdrawalButton)
    }
    
    
    func setupUI(){
        
    }
    
    func setupConstraints(){
        
    }

}
