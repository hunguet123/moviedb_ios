//
//  ReviewsViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 29/01/2023.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ReviewsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemReview", for: indexPath) as! ItemReviewCollectionViewCell
        return cell
    }
    
    
}
