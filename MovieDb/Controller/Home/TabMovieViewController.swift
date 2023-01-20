//
//  TabMovieViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 15/01/2023.
//

import UIKit
import SDWebImage

class TabMovieViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    //viewModel
    private var viewModel = TabMovieViewModel()

    var nameTabMovie = ""
    private var currentPage = 1
    private var listMovie: [Movie] = []
    private var selectMovieId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
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

extension TabMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (nameTabMovie != "") {
            viewModel.getTabMovies(nameTabMovie: nameTabMovie, page: 1)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemMovie", for: indexPath) as! ItemMovieCollectionViewCell
        let imageUrlString = NetworkConstant.shared.imageServerAddress + (listMovie[indexPath.row].posterPath ?? "neo")
        cell.imageMovie.layer.cornerRadius = 15
        cell.imageMovie.sd_setImage(with: URL(string: imageUrlString))
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage += 1
        viewModel.getTabMovies(nameTabMovie: nameTabMovie, page: currentPage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination.childViewControllerForPointerLock as? DetailViewController {
            controller.movieId = selectMovieId
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMovieId = listMovie[indexPath.row].id!
        self.performSegue(withIdentifier: "showMovieDetail", sender: nil)
    }
}
