//
//  DetailViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 19/01/2023.
//

import UIKit
import LZViewPager

class DetailViewController: UIViewController {

    //outlet
    @IBOutlet weak var buttonSave: UIBarButtonItem!
    @IBOutlet weak var imageBackDrop: UIImageView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelReleaseYear: UILabel!
    @IBOutlet weak var labelRunTimes: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    @IBOutlet weak var viewPager: LZViewPager!
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var labelOriginTitle: UILabel!
    //property
    var movieId: Int?
    private var reviews: [Review]?
    private var subControllers:[UIViewController] = []
    private lazy var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initData()
        createViewPager(viewModel: viewModel)
        bindViewModel()
    }
    
    private func setUpView() {
//        print(UIScreen.main.bounds.height)
//        print(imageBackDrop.bounds.height)
//        print(labelGenres.bounds.height)
        //scrollViewContainer.heightAnchor.constraint(equalToConstant: 1500).isActive = true
    }
    
    private func initData() {
        viewModel.getMovieDetail(movieId: movieId!)
        viewModel.getMovieReviews(movieId: movieId!)
    }
    
    private func bindViewModel() {
        viewModel.movie.bind {[weak self] movie in
            guard let self = self,
                  let movie = movie else {
                return
            }
            
            self.imageBackDrop.layer.cornerRadius = 15
            self.imagePoster.layer.cornerRadius = 15

            if movie.backdropPath != nil {
                let imageBackDropUrlString = NetworkConstant.shared.imageServerAddress + (movie.backdropPath!)
                self.imageBackDrop.sd_setImage(with: URL(string: imageBackDropUrlString))
            } else {
                self.imageBackDrop.image = UIImage(named: "bg_image_not_found")
            }
            
            if movie.posterPath != nil {
                let imagePosterPathUrlString = NetworkConstant.shared.imageServerAddress + (movie.posterPath!)
                self.imagePoster.sd_setImage(with: URL(string: imagePosterPathUrlString))
            } else {
                self.imagePoster.image = UIImage(named: "bg_image_not_found")
            }
            
            self.labelReleaseYear.text = String(self.viewModel.getYearFromReleaseDate(releaseDate: movie.releaseDate!))
            self.labelRunTimes.text = String(movie.runtime!) + "Minutes"
            
            //conver movie genres to string
            var textGenre = ""
            for genre in movie.genres! {
                textGenre += genre.name + " "
            }
            //set text label genres
            self.labelGenres.text = textGenre
            
            //set origin title movie
            self.labelOriginTitle.text = movie.originalTitle
        }
    }
    
    private func createViewPager(viewModel: DetailViewModel) {
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        let vc1 = mainStoryboard.instantiateViewController(withIdentifier: "AboutMovieViewController") as! AboutMovieViewController
        vc1.viewModel = self.viewModel
        vc1.title = "About Movie"
        
        let vc2 = mainStoryboard.instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
        vc2.viewModel = self.viewModel
        vc2.title = "Reviews"
        
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SimilarMovieViewController") as! SimilarMovieViewController
        vc3.viewModel = self.viewModel
        vc3.title = "Similar Movie"
        
        subControllers = [vc1, vc2, vc3]
        viewPager.reload()
    }
        
    @IBAction func onBackScreen(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}

extension DetailViewController: LZViewPagerDelegate, LZViewPagerDataSource {
    
    func numberOfItems() -> Int {
        return self.subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return self.subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }
    
    func backgroundColorForHeader() -> UIColor {
        return UIColor.clear
    }
    
}
