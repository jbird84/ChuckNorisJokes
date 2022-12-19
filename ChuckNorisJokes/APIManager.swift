//
//  APIManager.swift
//  NewsAPI
//
//  Created by Kinney Kare on 12/17/22.
//

import Foundation

class APIManager {
    
    func fetchData(completion: @escaping (Swift.Result<JokeModel, Error>) -> Void) {
        guard let url = URL(string:"https://api.chucknorris.io/jokes/random") else { return }
        let request = URLRequest(url: url)
        
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
    
    func fetchGifData(completion: @escaping (Swift.Result<GIF, Error>) -> Void) {
        guard let url = URL(string: "https://tenor.googleapis.com/v2/search?q=chuck_norris&key=AIzaSyBcv3DJnhdLS3b34pYWPJ-1l4gSUP8lk_w&client_key=Chuck_Norris_Jokes&limit=1&random=true") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                        let model = try decoder.decode(GIF.self, from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(APIError.invalidData))
                        print(error)
                    }
            }
            task.resume()
    }
}

enum APIError: Error {
    case invalidData
}
