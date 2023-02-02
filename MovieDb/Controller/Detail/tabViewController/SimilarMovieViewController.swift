//
//  SimilarMovieViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 29/01/2023.
//

import UIKit

class SimilarMovieViewController: UIViewController {

    //outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //property
    var viewModel: DetailViewModel?
    private var similars: [Movie] = []
    private var selectMovieId: Int?
    private var currentPage: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.similars.bind({ similarMovies in
            if similarMovies?.isEmpty == false {
                self.similars.append(contentsOf: similarMovies!)
                self.collectionView.reloadData()
            }
        })
    }
    
}

extension SimilarMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemSimilarMovie", for: indexPath) as! ItemMovieCollectionViewCell
        let indexMovie = similars[indexPath.row]
        cell.imageMovie.layer.cornerRadius = 15
        if indexMovie.posterPath != nil {
            let imageUrlString = NetworkConstant.shared.imageServerAddress + indexMovie.posterPath!
            cell.imageMovie.sd_setImage(with: URL(string: imageUrlString))
        } else {
            cell.imageMovie.image = UIImage(named: "bg_image_not_found")
        }
        return cell
    }
    
    // endless scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 && viewModel?.similars.value?.isEmpty == false {
            let movieId = viewModel?.movie.value?.id
            viewModel?.getMovieSimilars(movieId: movieId!, page: currentPage)
            currentPage+=1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMovieId = similars[indexPath.row].id!
        self.performSegue(withIdentifier: "showMovieDetail4", sender: nil)
    }
    
    // tranfer data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination.childViewControllerForPointerLock as? DetailViewController {
            controller.movieId = selectMovieId
        }
    }
    
}
