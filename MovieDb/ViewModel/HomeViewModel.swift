//
//  HomeViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 18/01/2023.
//

import Foundation

class HomeViewModel {
    var listMovie: [Movie] = []
    
    func getTrendingMovie(page: Int) {
        ApiCaller.getTrendingMovies(page: page) { result in
            switch result {
            case .success(let data):
                self.listMovie = data.results
            case .failure(let error):
                print(error)
        }
        }
    }
}
