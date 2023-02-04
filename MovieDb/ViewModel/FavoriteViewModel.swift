//
//  FavoriteViewModel.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 04/02/2023.
//

import Foundation
import CoreData
import UIKit

class FavoriteViewModel {
    var movies: Observable<[MovieDataCore]> = Observable(nil)
    
    private var fetchedResultsController: NSFetchedResultsController<MovieDataCore>!
    
    func fetchMovie() {
        let fetchRequest: NSFetchRequest<MovieDataCore> = MovieDataCore.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        //Lấy AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
               
        //lấy Managed Object Contexxt
        let managedContext = appDelegate.persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: managedContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
            movies.value = fetchedResultsController.fetchedObjects!
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
    }
    
}
