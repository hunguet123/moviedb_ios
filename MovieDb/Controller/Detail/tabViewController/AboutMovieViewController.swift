//
//  AboutMovieViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 29/01/2023.
//

import UIKit

class AboutMovieViewController: UIViewController {
    //outlet
    @IBOutlet weak var textViewAboutMovie: UITextView!
    
    
    //property
    var textAboutMovie: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        textViewAboutMovie.text = textAboutMovie
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
