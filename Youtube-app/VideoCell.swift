//
//  VideoCell.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 6/17/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class BaseClass: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){}
}

class VideoCell: BaseClass {
    
    var video: Video? {
        didSet{
            titleLabel.text = video?.videoTitle
            subtitleTextView.text = video?.videoSubtitle
            thumbnailImageView.image = UIImage(named: (video?.videoImageName)!)
            userProfileImageView.image = UIImage(named: (video?.chanel?.chanelImageName)!)
            
            // Mesure height title
            let labelHeight = (titleLabel.text?.height(withConstrainedWidth: frame.width - 16 - 44 - 8 - 16, font: UIFont.systemFont(ofSize: 17)))!
            if labelHeight > CGFloat(22) {
                titleHeightContrain?.constant = 44
            }else{
                titleHeightContrain?.constant = 22
            }
            
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleHeightContrain: NSLayoutConstraint?
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(seperateView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v2(44)]-25-[v1(1)]|", views: thumbnailImageView, seperateView, userProfileImageView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: seperateView)
        
        addConstraintWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)
        // Top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: userProfileImageView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        // Left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // Right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Height constraint
        titleHeightContrain = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleHeightContrain!)
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
}
