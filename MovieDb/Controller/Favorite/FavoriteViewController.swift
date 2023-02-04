//
//  FavoriteViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 14/01/2023.
//

import UIKit

class FavoriteViewController: UIViewController {

    private let viewModel = FavoriteViewModel()
    private var listMovie: [MovieDataCore] = []
    private var selectMovieId: Int = 0
    
    //outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageNoItemInDb: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchMovie()
    }
    
    
    private func bindViewModel() {
        viewModel.movies.bind { [weak self] movies in
            guard let self = self,
                  let movies = movies else {
                return
            }
            if movies.isEmpty == false {
                self.imageNoItemInDb.isHidden = true
            } else {
                self.imageNoItemInDb.isHidden = false
            }
            self.listMovie = movies
            self.collectionView.reloadData()
        }
    }

}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemMovieSearch", for: indexPath) as! ItemMovieSearchCollectionViewCell
        let indexMovie = listMovie[indexPath.row]
        cell.imageMovie.layer.cornerRadius = 15
        if indexMovie.posterPath != nil {
            let imageUrlString = NetworkConstant.shared.imageServerAddress + indexMovie.posterPath!
            cell.imageMovie.sd_setImage(with: URL(string: imageUrlString))
        } else {
            cell.imageMovie.image = UIImage(named: "bg_image_not_found")
        }
        cell.labelTitle.text = indexMovie.originalTitle
        cell.labelVoteAverage.text = String(indexMovie.voteAverage)
        cell.labelReleaseDate.text = indexMovie.releaseDate
        cell.labelGenres.text = indexMovie.genreNames
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMovieId = Int(listMovie[indexPath.row].id)
        self.performSegue(withIdentifier: "showMovieDetailFromFavoriteScreen", sender: nil)
    }
    
    // tranfer screen data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination.childViewControllerForPointerLock as? DetailViewController {
            controller.movieId = selectMovieId
        }
    }
        
}
