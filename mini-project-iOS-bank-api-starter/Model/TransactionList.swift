//
//  TransactionList.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Mubarak Aloraifan on 07/03/2024.
//

import Foundation
enum TransactionType: Codable{
    case transfer
    case deposit
    case withdraw
}

struct Transaction: Codable {
    let senderId: Int
    let receiverId: Int
    let amount: Double
    let type: TransactionType
}


