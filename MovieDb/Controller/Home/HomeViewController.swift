//
//  HomeViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 14/01/2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionViewMovieNowPlaying: UICollectionView!
    
    private var list = ["movie", "movie", "movie"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemMovieNowPlaying", for: indexPath) as! ItemMovieCollectionViewCell
        cell.imageMovie.image = UIImage(named: list[indexPath.row])
        cell.labelNumber.text = String(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        // code in here
        
    }
    
}
