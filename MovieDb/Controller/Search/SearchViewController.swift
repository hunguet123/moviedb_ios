//
//  SearchViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 14/01/2023.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    private var listMovie: [Movie] = []
    private var listGenre: [Genre] = []
    private var currentPage = 1
    private var selectMovieId : Int = 0
    private var query: String = ""
    
    //viewModel
    private let viewModel = SearchViewModel()
    
    
    //outlet
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imgSearchCanBeNotFound: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSearch.delegate = self
        setUpview()
        bindViewModel()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldSearch.resignFirstResponder()
        performAction()
        return true
    }
    
    private func performAction() {
        query = textFieldSearch.text!
        self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        viewModel.getSearchMovies(query: query, page: currentPage)
        viewModel.getGenres()
    }
    
    private func setUpview() {
        //setup button in textfild
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .clear
        let rightButton = UIButton(configuration: configuration)
        rightButton.setImage(UIImage(named: "Search"), for: .normal)
        rightButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        rightButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        
        textFieldSearch.rightView = rightButton
        textFieldSearch.rightViewMode = .always
        textFieldSearch.borderStyle = .none
        textFieldSearch.layer.cornerRadius = 15
        textFieldSearch.backgroundColor = UIColor(red: 0.227, green: 0.247, blue: 0.278, alpha: 1)
    }
    
    
    private func bindViewModel() {
        viewModel.movies.bind { [weak self] movies in
                    guard let self = self,
                          let movies = movies else {
                        return
                    }
            if movies.isEmpty == true {
                self.imgSearchCanBeNotFound.isHidden = false
            } else {
                self.imgSearchCanBeNotFound.isHidden = true
            }
            self.listMovie.append(contentsOf: movies)
            self.collectionView.reloadData()
        }
        
        viewModel.genres.bind { [weak self] genres in
            guard let self = self,
                  let genres = genres else {
                return
            }
            self.listGenre = genres
            self.collectionView.reloadData()
        }
        
        viewModel.error.bind { error in
            print("eroor \(error as Any)")
        }
    }
    
    @objc func onClick(_ sender: UIButton) {
        query = textFieldSearch.text!
        self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        viewModel.getSearchMovies(query: query, page: currentPage)
        viewModel.getGenres()
    }
    
    
    @IBAction func onChangeTextField(_ sender: UITextField) {
        if (sender.text?.isEmpty == true) {
            listMovie = []
            self.collectionView.reloadData()
            self.imgSearchCanBeNotFound.isHidden = true
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate , UICollectionViewDataSource, UIScrollViewDelegate {
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
        var genres = ""
        for genre in listGenre {
            if (indexMovie.genreIds?.contains(genre.id) == true) {
                genres += genre.name + " "
            }
        }
        cell.labelGenres.text = genres
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMovieId = listMovie[indexPath.row].id!
        self.performSegue(withIdentifier: "showMovieDetail3", sender: nil)
    }
    
    // tranfer screen data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination.childViewControllerForPointerLock as? DetailViewController {
            controller.movieId = selectMovieId
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentPage += 1
        viewModel.getSearchMovies(query: query, page: currentPage)
    }
    
}
