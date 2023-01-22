//
//  SearchViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 22/01/2023.
//

import Foundation

class SearchViewModel {
    var movies: Observable<[Movie]> = Observable(nil)
    var genres: Observable<[Genre]> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    
    func getSearchMovies(query: String, page: Int) {
        ApiCaller.getSearchMovies(query: query, page: page) { result in
            switch result {
            case .success(let data):
                self.movies.value = data.results
            case .failure(let error):
                self.error.value = error
        }
        }
    }
    
    func getGenres() {
        ApiCaller.getGenres { result in
            switch result {
            case .success(let data):
                self.genres.value = data.genres
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
}
