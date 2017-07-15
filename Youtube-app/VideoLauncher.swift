//
//  VideoLauncher.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 7/15/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addVideoPlayerAndPlayIt()
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.black
    }
    
    func addVideoPlayerAndPlayIt() {
        let url = "https://firebasestorage.googleapis.com/v0/b/clone-youtube-app.appspot.com/o/Luis%20Fonsi%20-%20Despacito%20ft.%20Daddy%20Yankee.mp4?alt=media&token=bf032a9a-6d4e-4735-bd1a-3bb5fbca4d3d"
        if let urlString = URL(string: url) {
            let videoPlayer = AVPlayer(url: urlString)
            let videoLayer = AVPlayerLayer(player: videoPlayer)
            videoLayer.frame = self.frame
            self.layer.addSublayer(videoLayer)
            
            videoPlayer.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    func showVideoPlayer () {
        if let keyWindow = UIApplication.shared.keyWindow {
            // Init new view and add it to keyWindow
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            // Add subviews for new view
            let height = view.frame.width * 9 / 16
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: height))
            view.addSubview(videoPlayerView)
            // Add view to keyWindow
            keyWindow.addSubview(view)
            // Animate view
            //   first animate frame
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            //   last animate frame
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                view.frame = keyWindow.frame
            }, completion: { (completed) in
                // Hide statusbar when VideoLauncher is showed
                UIApplication.shared.isStatusBarHidden = true
            })
        }
    }
    
    
}
