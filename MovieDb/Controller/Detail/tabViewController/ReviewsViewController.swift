//
//  ReviewsViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 29/01/2023.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    //property
    var viewModel: DetailViewModel?
    private var reviews: [Review]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.reviews.bind({ reviews in
            self.reviews = reviews
        })
    }
    
}

extension ReviewsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemReview", for: indexPath) as! ItemReviewCollectionViewCell
        let review = reviews![indexPath.row]
        cell.imageAvatar.layer.cornerRadius = 15
        var imageUrlString: String = ""
        if review.authorDetails.avatarPath != nil {
            if ((review.authorDetails.avatarPath?.contains(NetworkConstant.shared.URL_EXTERNAL_AVATAR)) == true) {
                let avatarPath = review.authorDetails.avatarPath
                let startOfSentence = avatarPath?.index(avatarPath!.startIndex, offsetBy: 1)
                imageUrlString = String(review.authorDetails.avatarPath![startOfSentence!...])
            } else {
                imageUrlString = NetworkConstant.shared.imageServerAddress + review.authorDetails.avatarPath!
            }
            cell.imageAvatar.sd_setImage(with: URL(string: imageUrlString))
        } else {
            cell.imageAvatar.image = UIImage(named: "bg_image_not_found")
        }
        
        cell.labelAuthor.text = review.authorDetails.username
        if review.authorDetails.rating != nil {
            let rating: Int = review.authorDetails.rating!
            cell.labelRating.text = String(rating)
        }
        cell.textViewContent.text = reviews![indexPath.row].content
        return cell
    }
    
    
}
