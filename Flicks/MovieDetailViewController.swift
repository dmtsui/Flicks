//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Dan Tsui on 2/7/16.
//  Copyright © 2016 Dan Tsui. All rights reserved.
//

import UIKit
import AFNetworking

class MoviewDetailViewController: UIViewController {
    var movieData: NSDictionary = NSDictionary()
    
    @IBOutlet weak var posterView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageURL = movieData["poster_path"]! as! String
        let url: NSURL = NSURL(string: "https://image.tmdb.org/t/p/original\(imageURL)")!
        posterView.setImageWithURL(url)
        
    }
}
