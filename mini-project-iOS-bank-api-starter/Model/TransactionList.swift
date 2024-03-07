//
//  TransactionList.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Mubarak Aloraifan on 07/03/2024.
//

import Foundation
struct TransactionList: Codable {
    let deposit: Double
    let withdraw: Double
    let balance: Double
}
