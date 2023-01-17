//
//  TabMovieViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 15/01/2023.
//

import UIKit

class TabMovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var currentList = [""]

    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemMovie", for: indexPath) as! ItemMovieCollectionViewCell
        cell.imageMovie.image = UIImage(named: currentList[indexPath.row])
        return cell
    }
    
}
