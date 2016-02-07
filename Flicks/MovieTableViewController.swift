//
//  MovieTableViewController.swift
//  Flicks
//
//  Created by Dan Tsui on 2/7/16.
//  Copyright © 2016 Dan Tsui. All rights reserved.
//

import UIKit
import AFNetworking

class MovieTableViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController : UISearchController!
    var feedData: [NSDictionary] = [NSDictionary]()
    var apiKey: String?
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSecrets()
        initSearchBar()

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.dtsui.MovieTableViewCell", forIndexPath: indexPath) as! MoviewTableViewCell
//        let item = self.feedData[indexPath.row]
//        let imageURL = item["images"]!["low_resolution"]!!["url"]! as! String
//        let url: NSURL = NSURL(string: imageURL)!
//        cell.photoView.setImageWithURL(url)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedData.count
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
    func loadSecrets() {
        if let path = NSBundle.mainBundle().pathForResource("secrets", ofType: "plist"), dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            apiKey = dict["apiKey"] as? String
        }
        
    }
}
