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
        ApiCaller.getTrendingMovies(page: page) { result in
            switch result {
            case .success(let data):
                self.movies.value = data.results
            case .failure(let error):
                self.error.value = error
        }
        }
    }
}
