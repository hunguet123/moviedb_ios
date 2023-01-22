//
//  TabMovieViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 19/01/2023.
//

import Foundation

class TabMovieViewModel {
    
    var movies: Observable<[Movie]> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    
    func getTabMovies(nameTabMovie: String, page: Int) {
        ApiCaller.getTabMovies(nameTabMovie: nameTabMovie, page: page) { result in
            switch result {
            case .success(let data):
                self.movies.value = data.results
            case .failure(let error):
                self.error.value = error
            }
        }
    }
        
}
