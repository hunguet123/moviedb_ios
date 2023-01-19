//
//  TabMovieViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 19/01/2023.
//

import Foundation

class TabMovieViewModel {
    
    var movies: Observable<[Movie]> = Observable(nil)
    var listMovie: [Movie] = []
    
    func getTabMovies(nameTabMovie: String, page: Int) {
        ApiCaller.getTabMovies(nameTabMovie: nameTabMovie, page: page) { result in
            switch result {
            case .success(let data):
                self.listMovie = data.results
                self.movies.value = self.listMovie
            case .failure(let error):
                print(error)
        }
    }
    }
}
