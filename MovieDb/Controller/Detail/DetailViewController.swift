//
//  DetailViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 19/01/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var buttonSave: UIBarButtonItem!
    
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movieId)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
    
    @IBAction func onBackScreen(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
