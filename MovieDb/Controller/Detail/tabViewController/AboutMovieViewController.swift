//
//  AboutMovieViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 29/01/2023.
//

import UIKit

class AboutMovieViewController: UIViewController {
    //outlet
    @IBOutlet weak var textViewAboutMovie: UITextView!
    
    
    //property
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.movie.bind({ movie in
            if movie != nil {
                self.textViewAboutMovie.text = movie?.overview
            }
        })
    }
    
    private func setUpView() {
        //textViewAboutMovie.text = textAboutMovie
    }
    
}
