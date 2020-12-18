//
//  BooksInt.swift
//  BooksApp
//
//  Created by Apple on 18/12/20.
//  Copyright © 2020 Assignment. All rights reserved.
//

import Foundation
import UIKit


class BooksInt: NSObject {
   // (Result<MoviesResponse, APIServiceError>) -> Void) {
    func getListOfBooks(date:String, completion: @escaping (Result<Response, Error>) -> Void) {
        let url = URL(string: "https://api.nytimes.com/svc/books/v2/lists/overview.json?published_date=\(date)&api-key=76363c9e70bc401bac1e6ad88b13bd1d")!
        let urlRequest = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        URLSession.shared.jsonDecodableTask(with: urlRequest, decoder: decoder) { (result: Result<Response, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}

enum URLError: Error {
    case noData, decodingError
}

extension URLSession {
    // A type safe URL loader that either completes with success value or error with Error
    func jsonDecodableTask<T: Decodable>(with url: URLRequest, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
       self.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let data = data, let _ = response else {
                    completion(.failure(URLError.noData))
                    return
                }
                do {
                    let decoded = try decoder.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch  {
                    completion(.failure(error))
                }
            }
        }
    }
    func jsonDecodableTask<T: Decodable>(with url: URL, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
       self.jsonDecodableTask(with: URLRequest(url: url), decoder: decoder, completion: completion)
    }
}
