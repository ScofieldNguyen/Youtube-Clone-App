//
//  VideoView.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 7/23/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class VideoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // VideoView setup
        self.backgroundColor = UIColor.white
        if let keyWindow = UIApplication.shared.keyWindow {
            self.frame = keyWindow.frame
        }
        
        setupViews()
    }
    
    lazy var videoPlayerView: VideoPlayerView = {
        let height = self.frame.width * 9 / 16
        let vv = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: height))
        return vv
    }()
    
    func setupViews() {
        addSubview(videoPlayerView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view === self {
            // Touched ouside
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.videoPlayerView.controlViews.isHidden = true
            }) { (completed) in
                // Do something here
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
