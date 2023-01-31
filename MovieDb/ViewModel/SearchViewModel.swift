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
        let urlQuery = query.replacingOccurrences(of: " ", with: "%20")
        let urlString = NetworkConstant.shared.serverAddress +
        "search/movie" + "?query=" + urlQuery + "&page=" + String(page) + "&api_key=" + NetworkConstant.shared.keyApi +
        "&language=en-US"
        URLSession.shared.request(urlString: urlString, expecting: MoviesResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self!.movies.value = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getGenres() {
        let urlString = NetworkConstant.shared.serverAddress +
        "genre/movie/list" + "?api_key=" + NetworkConstant.shared.keyApi
        URLSession.shared.request(urlString: urlString, expecting: GenresResponse.self) { result in
            switch result {
            case .success(let data):
                self.genres.value = data.genres
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
