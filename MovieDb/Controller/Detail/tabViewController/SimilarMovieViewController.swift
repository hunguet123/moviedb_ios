//
//  SimilarMovieViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 29/01/2023.
//

import UIKit

class SimilarMovieViewController: UIViewController {

    //property
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension SimilarMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemSimilarMovie", for: indexPath) as! ItemMovieCollectionViewCell
        cell.imageMovie.layer.cornerRadius = 15
        cell.imageMovie.image = UIImage(named: "movie")
        return cell
    }
    
    
}
