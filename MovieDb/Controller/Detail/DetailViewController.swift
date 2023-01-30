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
    
    //property
    var movieId: Int?
    private var subControllers:[UIViewController] = []
    private lazy var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewPager()
        setUpView()
    }
    
    private func setUpView() {
        print(UIScreen.main.bounds.height)
        print(imageBackDrop.bounds.height)
        print(labelGenres.bounds.height)
        //scrollViewContainer.heightAnchor.constraint(equalToConstant: 1500).isActive = true
    }
    
    private func createViewPager() {
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        let vc1 = mainStoryboard.instantiateViewController(withIdentifier: "AboutMovieViewController")
        vc1.title = "About Movie"
        
        let vc2 = mainStoryboard.instantiateViewController(withIdentifier: "ReviewsViewController")
        vc2.title = "Reviews"
        
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SimilarMovieViewController")
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
