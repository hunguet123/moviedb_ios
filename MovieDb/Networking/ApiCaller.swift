//
//  ApiCaller.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 18/01/2023.
//

import Foundation

enum NetWorkError: Error {
    case urlError
    case canNotParseData
}

public class ApiCaller {
    static func getTrendingMovies(
        page: Int,
        completionHandler: @escaping (_ result: Result<MoviesResponse, NetWorkError>) -> Void) {
            let urlString = NetworkConstant.shared.serverAddress +
            "trending/all/day?api_key=" +
            NetworkConstant.shared.keyApi + "&page=" + String(page)
            
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.urlError))
                return
            }
            
            URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
                if error == nil,
                    let data = dataResponse,
                   let resultData = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
                    completionHandler(.success(resultData))
                } else {
                    completionHandler(.failure(.canNotParseData))
                }
        }.resume()
    }
    
    static func getTabMovies(
        nameTabMovie: String,
        page: Int,
        completionHandler: @escaping (_ result: Result<MoviesResponse, NetWorkError>) -> Void
    ) {
        let urlString = NetworkConstant.shared.serverAddress +
        "movie/" + nameTabMovie + "?api_key=" + NetworkConstant.shared.keyApi + "&page=" + String(page)
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
                let data = dataResponse,
               let resultData = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getSearchMovies(
        query: String,
        page: Int,
        completionHandler: @escaping (_ result: Result<MoviesResponse, NetWorkError>) -> Void
    ) {
        let urlString = NetworkConstant.shared.serverAddress +
        "search/movie" + "?query=" + query + "&page=" + String(page) + "&api_key=" + NetworkConstant.shared.keyApi +
        "&language=en-US"

        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
                let data = dataResponse,
               let resultData = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getGenres(
        completionHandler: @escaping (_ result: Result<GenresResponse, NetWorkError>) -> Void
    ) {
        let urlString = NetworkConstant.shared.serverAddress +
        "genre/movie/list" + "?api_key=" + NetworkConstant.shared.keyApi

        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
                let data = dataResponse,
               let resultData = try? JSONDecoder().decode(GenresResponse.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
}
