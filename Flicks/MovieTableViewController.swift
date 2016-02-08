//
//  MovieTableViewController.swift
//  Flicks
//
//  Created by Dan Tsui on 2/7/16.
//  Copyright © 2016 Dan Tsui. All rights reserved.
//

import UIKit
import AFNetworking
import EZLoadingActivity

class MovieTableViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController : UISearchController!
    var feedData: [NSDictionary] = [NSDictionary]()
    var apiKey = ""
    var endpoint = ""
    var dataURL: NSURL {
        return NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")!
    }
    
    @IBOutlet var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadSecrets()
        initSearchBar()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.dtsui.MovieTableViewCell", forIndexPath: indexPath) as! MoviewTableViewCell
        let item = self.feedData[indexPath.row]
        let imageURL = item["poster_path"]! as! String
        let url: NSURL = NSURL(string: "https://image.tmdb.org/t/p/w342\(imageURL)")!
        cell.posterView.setImageWithURL(url)
        if let title = item["title"] as? String {
            cell.titleLabel.text = title
        }
        if let overview = item["overview"] as? String {
            cell.overviewLabel.text = overview
            cell.overviewLabel.sizeToFit()
        }
        return cell
    }
    
    func updateData(refreshControl: UIRefreshControl) {
        // Do any additional setup after loading the view, typically from a nib.
        EZLoadingActivity.show("Uploading...", disableUI: false)
        let request = NSURLRequest(URL: dataURL)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.feedData = (responseDictionary["results"] as? [NSDictionary])!
                            self.tableView.reloadData()
                            refreshControl.endRefreshing()
                            
                    }
                }
        });
        task.resume()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView count: \(self.feedData.count)")
        return self.feedData.count
    }

    func initSearchBar() {
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
            if let apiKey = dict["apiKey"] as? String {
                self.apiKey = apiKey
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let cellData = feedData[indexPath!.row]
        let detailViewController = segue.destinationViewController as! MoviewDetailViewController
        detailViewController.movieData = cellData
        
        print("this segued wayed!")
    }
}
