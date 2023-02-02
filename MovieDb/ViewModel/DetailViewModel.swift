//
//  DetailViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 31/01/2023.
//

import Foundation

class DetailViewModel {
    var movie: Observable<Movie> = Observable(nil)
    var reviews: Observable<[Review]> = Observable(nil)
    var similars: Observable<[Movie]> = Observable(nil)

    func getMovieDetail(movieId: Int) {
        let urlString = NetworkConstant.shared.serverAddress +
        "movie/" + String(movieId) + "?api_key=" + NetworkConstant.shared.keyApi +
        "&language=en-US"
        URLSession.shared.request(urlString: urlString, expecting: Movie.self) { [weak self] result in
            switch result {
            case .success(let data):
                self!.movie.value = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieReviews(movieId: Int, page: Int) {
        let urlString = NetworkConstant.shared.serverAddress +
        "movie/" + String(movieId) + "/reviews" + "?api_key=" + NetworkConstant.shared.keyApi +
        "&language=en-US" + "&page=" + String(page)
        URLSession.shared.request(urlString: urlString, expecting: ReviewResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self!.reviews.value = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieSimilars(movieId: Int, page: Int) {
        let urlString = NetworkConstant.shared.serverAddress +
        "movie/" + String(movieId) + "/similar" + "?api_key=" + NetworkConstant.shared.keyApi +
        "&language=en-US" + "&page=" + String(page)
        URLSession.shared.request(urlString: urlString, expecting: MoviesResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self!.similars.value = data.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getYearFromReleaseDate(releaseDate: String) -> Int {
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Convert String to Date
        let date = dateFormatter.date(from: releaseDate)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date!)
        return components.year ?? 2022
    }
    
}
