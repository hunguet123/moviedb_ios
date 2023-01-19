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
    var viewModel = TabMovieViewModel()

    var nameTabMovie = ""
    private var listMovie: [Movie] = []

    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        bindViewModel()
    }
    
}

extension TabMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (nameTabMovie != "") {
            viewModel.getTabMovies(nameTabMovie: nameTabMovie, page: 1)
        }
    }
    
    private func bindViewModel() {
        viewModel.movies.bind { [weak self] movies in
                    guard let self = self,
                          let movies = movies else {
                        return
                    }
            self.listMovie = movies
            self.collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
