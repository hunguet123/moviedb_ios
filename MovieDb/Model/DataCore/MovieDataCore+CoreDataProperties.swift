//
//  MovieDataCore+CoreDataProperties.swift
//  
//
//  Created by Hà Quang Hưng on 03/02/2023.
//
//

import Foundation
import CoreData


extension MovieDataCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDataCore> {
        return NSFetchRequest<MovieDataCore>(entityName: "MovieDataCore")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var genreNames: String?
    @NSManaged public var id: Int64
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var runtime: Int64
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int64

}
