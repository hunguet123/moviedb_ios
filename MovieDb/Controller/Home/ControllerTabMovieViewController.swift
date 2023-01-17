//
//  ControllerTabMovieViewController.swift
//  MovieDb
//
//  Created by Hà Quang Hưng on 17/01/2023.
//

import UIKit

class ControllerTabMovieViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var uiSegmentControlTabMovie: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var nowplayingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabMovie") as! TabMovieViewController
    private lazy var upComingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabMovie") as! TabMovieViewController
    private lazy var topRatedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabMovie") as! TabMovieViewController
    private lazy var popularVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabMovie") as! TabMovieViewController

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: containerView.frame.width*4, height: 0)
        view.addSubview(scrollView)
        setUpViewForTabMovie()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = containerView.frame
        scrollView.delegate = self
        addChildVCs()
    }
            
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        switch targetContentOffset.pointee.x {
        case 0:
            uiSegmentControlTabMovie.selectedSegmentIndex = 0
        case containerView.frame.width:
            uiSegmentControlTabMovie.selectedSegmentIndex = 1
        case containerView.frame.width*2:
            uiSegmentControlTabMovie.selectedSegmentIndex = 2
        default:
            uiSegmentControlTabMovie.selectedSegmentIndex = 3
        }
    }
    
    private func setUpViewForTabMovie() {
        let listUpcoming = ["movie", "movie", "movie","movie", "movie", "movie",
                                    "movie", "movie", "movie","movie", "movie", "movie",
                                    "movie", "movie", "movie","movie", "movie", "movie",
                                    "movie", "movie", "movie","movie", "movie", "movie",
                                    "movie", "movie", "movie","movie", "movie", "movie",
                                    "movie", "movie", "movie","movie", "movie", "movie"]
        nowplayingVC.currentList = listUpcoming
        topRatedVC.currentList = listUpcoming
        popularVC.currentList = listUpcoming
    }
    
    private func addChildVCs() {
        addChild(nowplayingVC)
        addChild(upComingVC)
        addChild(topRatedVC)
        addChild(popularVC)
        
        scrollView.addSubview(nowplayingVC.view)
        scrollView.addSubview(upComingVC.view)
        scrollView.addSubview(topRatedVC.view)
        scrollView.addSubview(popularVC.view)
        
        nowplayingVC.view.frame = CGRect(x: 0,
                                         y: 0,
                                         width: containerView.frame.width,
                                         height: containerView.frame.height)
        upComingVC.view.frame = CGRect(x: containerView.frame.width,
                                       y: 0,
                                       width: containerView.frame.width,
                                       height: containerView.frame.height)
        topRatedVC.view.frame = CGRect(x: containerView.frame.width*2,
                                      y: 0,
                                       width: containerView.frame.width,
                                       height: containerView.frame.height)
        popularVC.view.frame = CGRect(x: containerView.frame.width*3,
                                      y: 0,
                                      width: containerView.frame.width,
                                      height: containerView.frame.height)
        
        nowplayingVC.didMove(toParent: self)
        upComingVC.didMove(toParent: self)
        topRatedVC.didMove(toParent: self)
        popularVC.didMove(toParent: self)
    }
    

    @IBAction func onChangeTabMovie(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            scrollView.setContentOffset(.zero, animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x: containerView.frame.width, y: 0), animated: true)
        case 2:
            scrollView.setContentOffset(CGPoint(x: containerView.frame.width*2, y: 0), animated: true)
        default:
            scrollView.setContentOffset(CGPoint(x: containerView.frame.width*3, y: 0), animated: true)
        }
    }
    
}
