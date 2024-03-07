//
//  TransactionListViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Mubarak Aloraifan on 07/03/2024.
//

import UIKit

class TransactionListViewController: UITableViewController {
    
    var transactions: [Transaction] = []
    var token: String?
    var types: TransactionType = .deposit // Default type
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Reload button setup
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise.circle"),
            style: .plain,
            target: self,
            action: #selector(reloadButtonPressed)
        )
        
        // Setup navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Fetch transaction list initially
        fetchTransactionList()
    }
    
    @objc func reloadButtonPressed() {
        fetchTransactionList()
    }
    
    func fetchTransactionList() {
        guard let token = token else {
            print("Token is missing")
            return
        }
        
        NetworkManager.shared.fetchTransactionList(token: token) { result in
            switch result {
            case .success(let transactions):
                print("Successful transaction: \(transactions)")
                self.transactions = transactions
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = "\(transaction.type)"
        
        if transaction.type == types {
            cell.imageView?.image = UIImage(named: "deposit")
        } else {
            cell.imageView?.image = UIImage(named: "withdraw")
        }
        
        cell.textLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = " \(transaction.amount)KWD"
        cell.detailTextLabel?.textColor = transaction.type == types ? .green : .red
        
        return cell
    }
}
