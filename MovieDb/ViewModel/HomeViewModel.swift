//
//  HomeViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 18/01/2023.
//

import Foundation

class HomeViewModel {
    var movies: Observable<[Movie]> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    
    func getTrendingMovie(page: Int) {
        let urlString = NetworkConstant.shared.serverAddress +
        "trending/all/day?api_key=" +
        NetworkConstant.shared.keyApi + "&page=" + String(page)
        URLSession.shared.request(urlString: urlString, expecting: MoviesResponse.self) { result in
            switch result {
            case .success(let data):
                self.movies.value = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
}
