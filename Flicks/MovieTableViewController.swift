//
//  MovieTableViewController.swift
//  Flicks
//
//  Created by Dan Tsui on 2/7/16.
//  Copyright © 2016 Dan Tsui. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()

    }
    
    private func initSearchBar() {
        searchController = UISearchController(searchResultsController:  nil)
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        
        navigationItem.titleView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        print("search was updated \(searchController.searchBar.text)")
    }
}
