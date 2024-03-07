//
//  NetworkManager.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import Foundation
import Alamofire
class NetworkManager {
    private let baseUrl = "https://coded-bank-api.eapi.joincoded.com/"
    
    static let shared = NetworkManager()
    
     func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
     func deposit(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "deposit"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signin(username: String,password: String, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
       let url = baseUrl + "signin"
        let parameters : [String: String] = ["username": username,"password": password]
       AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
           switch response.result {
           case .success(let value):
               completion(.success(value))
           case .failure(let afError):
               completion(.failure(afError as Error))
           }
       }
   }
    func withdraw(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
       let url = baseUrl + "withdraw"
       let headers: HTTPHeaders = [.authorization(bearerToken: token)]
       AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
           if let error = response.error {
               completion(.failure(error))
           } else {
               completion(.success(()))
           }
       }
   }
    
    func fetchAccount(token: String,completion: @escaping (ProfileDetails?) -> Void){
        let url = baseUrl + "account"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, headers: headers).responseDecodable(of: ProfileDetails.self){ response in
               switch response.result{
               case .success(let account):
                   completion(account)
               case .failure(let error):
                   completion(nil)
                   print(error)
               }
           }
       }
    
    
    
    func fetchTransactionList(token: String, amountChange: AmountChange,completion: @escaping ([TransactionList]?) -> Void){
           AF.request(baseUrl + "account", method: .get, parameters: amountChange).responseDecodable(of: [TransactionList].self){ response in
               switch response.result{
               case .success(let transaction):
                   completion(transaction)
               case .failure(let error):
                   completion(nil)
                   print(error)
               }
           }
       }
    //MARK: OTHER Networking Functions
    
    
}
