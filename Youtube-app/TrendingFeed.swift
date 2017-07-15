//
//  TrendingCell.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 7/14/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class TrendingFeed: FeedCell {
    
    override func fetchVideo() {
        ApiService.sharedInstance.fetchTrendingVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
