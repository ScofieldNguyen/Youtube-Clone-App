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
        self.backgroundColor = UIColor.black
        
        addVideoPlayerAndPlayIt()
        setupViews()
    }
    
    
    
    var videoPlayer: AVPlayer?
    
    var isPlaying = false
    
    var videoIsReady = false
    
    lazy var videoDuration: Float64 = {
        var totalSeconds: Float64 = 0
        if let duration = self.videoPlayer?.currentItem?.asset.duration {
            totalSeconds = CMTimeGetSeconds(duration)
        }
        return totalSeconds
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Show controlViews on tapping
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//            self.controlViews.isHidden = false
//        }) { (completed) in
//            // Do something here
//        }
    }
    
    lazy var pauseStartButton: UIButton = {
        let pb = UIButton(type: UIButtonType.system)
        pb.translatesAutoresizingMaskIntoConstraints = false
        pb.setImage(UIImage(named: "pause"), for: .normal)
        pb.tintColor = UIColor.white
        pb.isHidden = true
        pb.addTarget(self, action: #selector(handlePauseStartButton), for: .touchUpInside)
        return pb
    }()
    
    func handlePauseStartButton() {
        if isPlaying {
            pauseStartButton.setImage(UIImage(named: "start"), for: .normal)
            videoPlayer?.pause()
        }else{
            pauseStartButton.setImage(UIImage(named: "pause"), for: .normal)
            videoPlayer?.play()
        }
        isPlaying = !isPlaying
    }
    
    var spinnerLoad: UIActivityIndicatorView = {
        let sl = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.hidesWhenStopped = true
        return sl
    }()
    
    let lengthSlider: UISlider = {
        let ls = UISlider()
        ls.translatesAutoresizingMaskIntoConstraints = false
        ls.minimumTrackTintColor = UIColor.red
        ls.maximumTrackTintColor = UIColor.white
        ls.setThumbImage(UIImage(named: "oval"), for: .normal)
        // Handle when lengthSLider's value changed
        ls.addTarget(self, action: #selector(handleSliderValueChanged), for: .valueChanged)
        return ls
    }()
    
    func handleSliderValueChanged() {
//        print(lengthSlider.value)
        
        if videoIsReady {
            let seekToSecond = Float64(lengthSlider.value) * videoDuration
            videoPlayer?.seek(to: CMTime(value: Int64(seekToSecond), timescale: 1), completionHandler: { (seekCompleted) in
                // Do something here later
            })
        }
    }
    
    let timeLabel: UILabel = {
        let ll = UILabel()
        ll.translatesAutoresizingMaskIntoConstraints = false
        ll.text = "00:00"
        ll.textColor = UIColor.white
        ll.font = UIFont.boldSystemFont(ofSize: 14)
        ll.textAlignment = .right
        return ll
    }()
    
    let currentTimeLabel: UILabel = {
        let ll = UILabel()
        ll.translatesAutoresizingMaskIntoConstraints = false
        ll.text = "00:00"
        ll.textColor = UIColor.white
        ll.font = UIFont.boldSystemFont(ofSize: 14)
        ll.textAlignment = .left
        return ll
    }()
    
    lazy var controlViews: UIView = {
        // Setting control views
        let cv = UIView()
        cv.frame = self.frame
        cv.backgroundColor = UIColor(white: 0, alpha: 1.0)
        
        return cv
    }()
    
    func setupViews() {
        addSubview(controlViews)
        
        // Dark gradient layer for controlViews
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = controlViews.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlViews.layer.addSublayer(gradientLayer)
        
        // Adding spinnerLoad to controlViews and start animating
        controlViews.addSubview(spinnerLoad)
        spinnerLoad.centerXAnchor.constraint(equalTo: controlViews.centerXAnchor).isActive = true
        spinnerLoad.centerYAnchor.constraint(equalTo: controlViews.centerYAnchor).isActive = true
        spinnerLoad.startAnimating()
        
        // Adding pause and start buttons to controlViews
        controlViews.addSubview(pauseStartButton)
        pauseStartButton.centerXAnchor.constraint(equalTo: controlViews.centerXAnchor).isActive = true
        pauseStartButton.centerYAnchor.constraint(equalTo: controlViews.centerYAnchor).isActive = true
        pauseStartButton.widthAnchor.constraint(equalToConstant: 50).isActive
         = true
        pauseStartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Adding timeLabel to controlViews
        controlViews.addSubview(timeLabel)
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Adding durationLabel to controlViews
        controlViews.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Adding lengthSlider to controlViews
        controlViews.addSubview(lengthSlider)
        lengthSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lengthSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        lengthSlider.rightAnchor.constraint(equalTo: timeLabel.leftAnchor).isActive = true
        lengthSlider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        // Hide controlViews by default
        controlViews.isHidden = true
    }
    
    func addVideoPlayerAndPlayIt() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/clone-youtube-app.appspot.com/o/Luis%20Fonsi%20-%20Despacito%20ft.%20Daddy%20Yankee.mp4?alt=media&token=bf032a9a-6d4e-4735-bd1a-3bb5fbca4d3d"
        
        if let url = URL(string: urlString) {
            videoPlayer = AVPlayer(url: url)
            let videoLayer = AVPlayerLayer(player: videoPlayer)
            videoLayer.frame = self.frame
            self.layer.addSublayer(videoLayer)
            // Observe when videoPlayer is ready
            videoPlayer?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: .new, context: nil)
            videoPlayer?.play()
            
            // update UI period with videoPlayer
            let interval = CMTime(value: 1, timescale: 2)
            videoPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (time) in
                let seconds = CMTimeGetSeconds(time)
                // Update slider
                self.lengthSlider.value = Float(seconds / self.videoDuration)
                // Update currentTimeLabel
                let secondInt64 = Int64(seconds)
                self.currentTimeLabel.text = secondInt64.videoLenghtStringFormat
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItemStatus
            
            // Get the status change from the change dictionary
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItemStatus(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            if status == .readyToPlay {
                // Switch over the status
                DispatchQueue.main.async {
                    self.spinnerLoad.stopAnimating()
                    self.controlViews.backgroundColor = UIColor(white: 0, alpha: 0)
                    self.pauseStartButton.isHidden = false
                    let seconds = Int64(self.videoDuration)
                    self.timeLabel.text = seconds.videoLenghtStringFormat
                }
                isPlaying = true
                videoIsReady = true
            }
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
