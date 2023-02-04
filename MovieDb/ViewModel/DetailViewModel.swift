//
//  DetailViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 31/01/2023.
//

import Foundation
import UIKit
import CoreData

class DetailViewModel {
    var movie: Observable<Movie> = Observable(nil)
    var reviews: Observable<[Review]> = Observable(nil)
    var similars: Observable<[Movie]> = Observable(nil)
    private var fetchedResultsController: NSFetchedResultsController<MovieDataCore>!

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
                print("call movie reviews eroor \(error)")
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
    
    func saveMovie(_movie: Movie) {
        //Lấy AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
               
        //lấy Managed Object Contexxt
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieDataCore", in: managedContext)!
        
        let movie = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movie.setValue(_movie.posterPath, forKeyPath: "posterPath")
        movie.setValue(_movie.id, forKey: "id")
        movie.setValue(_movie.title, forKeyPath: "title")
        movie.setValue(_movie.voteAverage, forKeyPath: "voteAverage")
        movie.setValue(_movie.releaseDate, forKeyPath: "releaseDate")
        var genreNames = ""
        for genre in _movie.genres! {
            genreNames += genre.name
        }
        movie.setValue(genreNames, forKeyPath: "genreNames")
        
        do {
            try managedContext.save()
            print("Succcess save")
        } catch let err as NSError {
            print(err)
        }
        
    }
    
    func deleteMovie(movieId: Int) {
        let fetchRequest: NSFetchRequest<MovieDataCore> = MovieDataCore.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == \(movieId)")
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                   
        let managedContext = appDelegate.persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: managedContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
            let movieById = fetchedResultsController.fetchedObjects?.first
            managedContext.delete(movieById!)
            try managedContext.save()
        } catch let error as NSError {
            print("cannot delete \(error)")
        }
                   
    }
    
    func isMovieInsideById(movieId: Int)-> Bool {
        let fetchRequest: NSFetchRequest<MovieDataCore> = MovieDataCore.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == \(movieId)")
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        //Lấy AppDelegate
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
               
        //lấy Managed Object Contexxt
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: managedContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
            let movieById = fetchedResultsController.fetchedObjects
            if movieById?.isEmpty == true {
                return false
            }
            return true
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
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
