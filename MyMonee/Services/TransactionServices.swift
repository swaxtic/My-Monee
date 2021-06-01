//
//  ApiServices.swift
//  MyMonee
//
//  Created by MacBook on 20/05/21.
//

import Foundation

class TransactionServices {
    let url = "https://60a5ee61c0c1fd00175f4c04.mockapi.io/api/v1/transaction"
    
    func getTransactionList(completion: @escaping (_ data: [TransactionResponse]) -> ()){
        var components = URLComponents(string: self.url)
        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                    let transactionData = try! decoder.decode([TransactionResponse].self, from: data)
                    completion(transactionData)
            }
            if let httpResponse = response as? HTTPURLResponse{
                httpResponse.statusCode
            }
        }
        task.resume()
    }
    
    func getTransactionById(id: String,completion: @escaping (_ data: TransactionResponse) -> ()){
        var components = URLComponents(string: self.url)
        var request = URLRequest(url: URL(string: url+"/\(id)")!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                    let transactionData = try! decoder.decode(TransactionResponse.self, from: data)
                    completion(transactionData)
            }
            if let httpResponse = response as? HTTPURLResponse{
                print(httpResponse.statusCode)
            }
        }
        task.resume()
    }
    
    func postTransaction(uploadDataModel: TransactionResponse,completion: @escaping () -> ()){
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion()
            if let httpResponse = response as? HTTPURLResponse{
                httpResponse.statusCode
            }
        }
        task.resume()
    }
    
    func editTransaction(uploadDataModel: TransactionResponse,completion: @escaping () -> ()){
        var request = URLRequest(url: URL(string: url+"/\(uploadDataModel.id)")!)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion()
            if let httpResponse = response as? HTTPURLResponse{
                httpResponse.statusCode
            }
        }
        task.resume()
    }
    
    func deleteTransaction(id: String,completion: @escaping () -> ()){
        var request = URLRequest(url: URL(string: url+"/\(id)")!)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion()
            if let httpResponse = response as? HTTPURLResponse{
                httpResponse.statusCode
            }
        }
        task.resume()
    }
}
