//
//  TableViewCell.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 22/01/2023.
//

import UIKit

class ItemMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
