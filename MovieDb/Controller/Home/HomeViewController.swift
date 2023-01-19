//
//  HomeViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 14/01/2023.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    //set list movie
    //what is list???
    //todo: rename for meaning
    private var listMovie: [Movie] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //viewModel
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTrendingMovie(page: 1)
    }
        
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.listMovie = viewModel.listMovie
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemMovieNowPlaying", for: indexPath) as! ItemMovieCollectionViewCell
        let imageUrlString = NetworkConstant.shared.imageServerAddress + listMovie[indexPath.row].posterPath!
        
        
        cell.imageMovie.layer.cornerRadius = 15
        cell.imageMovie.sd_setImage(with: URL(string: imageUrlString))
        cell.labelNumber.text = String(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        // code in here
        
    }
}
