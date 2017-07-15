//
//  HomeCell.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 7/14/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class HomeFeed: FeedCell {

    override func fetchVideo() {
        ApiService.sharedInstance.fetchHomeVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
