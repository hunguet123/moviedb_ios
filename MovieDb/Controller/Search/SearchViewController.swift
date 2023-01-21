//
//  SearchViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 14/01/2023.
//

import UIKit

class SearchViewController: UIViewController {
    private var listMovie: [Movie] = []
    private var currentPage = 1
    private var selectMovieId : Int = 0
    
    
    //outlet
    @IBOutlet weak var textFieldSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
    }
    
    private func setUpview() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .clear
        let rightButton = UIButton(configuration: configuration)
        rightButton.setImage(UIImage(named: "Search"), for: .normal)
        rightButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        rightButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        
        textFieldSearch.rightView = rightButton
        textFieldSearch.rightViewMode = .always
        textFieldSearch.borderStyle = .none
        textFieldSearch.layer.cornerRadius = 15
        textFieldSearch.backgroundColor = UIColor(red: 0.227, green: 0.247, blue: 0.278, alpha: 1)
    }
    
    @objc func onClick(_ sender: UIButton) {
        print("helle")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemMovieSearch", for: indexPath) as! ItemMovieTableViewCell
        let imageUrlString = NetworkConstant.shared.imageServerAddress + listMovie[indexPath.row].posterPath!
        cell.imageMovie.layer.cornerRadius = 15
        cell.imageMovie.sd_setImage(with: URL(string: imageUrlString))
        return cell
    }
    
    
}
