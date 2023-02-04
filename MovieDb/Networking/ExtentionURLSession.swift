//
//  ApiCaller.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 18/01/2023.
//

import Foundation

extension URLSession {
    enum NetWorkError: Error {
        case urlError
        case canNotParseData
    }
    
    func request<T: Codable>(
        urlString: String,
        expecting: T.Type,
        completionHandler: @escaping (_ result: Result<T, NetWorkError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(expecting, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
        
    }
    
}
