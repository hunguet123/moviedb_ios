//
//  NetworkConstant.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 18/01/2023.
//

import Foundation

class NetworkConstant {
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
        //singleton
    }
    
    public var keyApi: String {
        get {
            return "b6dc2e39cbff00ca0001fb158d48bba6"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var language: String {
        get {
            return "en-US"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/original"
        }
    }
}
