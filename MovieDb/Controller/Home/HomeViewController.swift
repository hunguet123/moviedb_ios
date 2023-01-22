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
    private var currentPage = 1
    private var selectMovieId : Int = 0
    
    //outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //viewModel
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
        
    private func bindViewModel() {
        viewModel.movies.bind { [weak self] movies in
                    guard let self = self,
                          let movies = movies else {
                        return
                    }
            self.listMovie.append(contentsOf: movies)
            self.collectionView.reloadData()
        }
        
        viewModel.error.bind { error in
            print(error as Any)
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getTrendingMovie(page: currentPage)
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
    
    //endless scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage += 1
        viewModel.getTrendingMovie(page: currentPage)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMovieId = listMovie[indexPath.row].id!
        self.performSegue(withIdentifier: "showMovieDetail1", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination.childViewControllerForPointerLock as? DetailViewController {
            controller.movieId = selectMovieId
        }
    }
}
