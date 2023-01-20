//
//  SearchViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 14/01/2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var textFieldSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
    }
    
    private func setUpview() {
        textFieldSearch.layer.cornerRadius = 50
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        rightButton.setImage(UIImage(named: "Search"), for: .normal)
        textFieldSearch.rightView = rightButton
        textFieldSearch.rightViewMode = .always
    }
    
}
