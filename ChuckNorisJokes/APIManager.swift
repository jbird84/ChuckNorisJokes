//
//  APIManager.swift
//  NewsAPI
//
//  Created by Kinney Kare on 12/17/22.
//

import Foundation


//https://api.chucknorris.io/jokes/random

class APIManager {
    
    func fetchData(with: String, completion: @escaping (Result<JokeModel, Error>) -> Void) {
        guard let url = URL(string:"https://api.chucknorris.io/jokes/random") else { return }
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"key\":\"value\"}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(JokeModel.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}

enum APIError: Error {
    case invalidData
}
