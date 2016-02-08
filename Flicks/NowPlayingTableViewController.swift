//
//  NowPlayingTableViewController.swift
//  Flicks
//
//  Created by Dan Tsui on 2/7/16.
//  Copyright © 2016 Dan Tsui. All rights reserved.
//

import UIKit

class NowPlayingTableViewController: MovieTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        endpoint = "now_playing"
        endpoint = "now_playing"
        let refreshControl = UIRefreshControl()
        updateData(refreshControl)
        
    }
}
