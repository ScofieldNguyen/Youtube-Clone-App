//
//  ViewController.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 5/9/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let videos: [Video] = {
        let chanel = Chanel()
        chanel.chanelName = "Đời Sống Sinh Viên"
        chanel.chanelImageName = "doisongsinhvienChanel"
        
        let video1 = Video()
        video1.videoTitle = "Cá nướng giấy bạc"
        video1.chanel = chanel
        video1.videoSubtitle = "\((video1.chanel?.chanelName)!) · 65K views · 1 year ago"
        video1.videoImageName = "thumbnailVideoImage"
        
        let video2 = Video()
        video2.videoTitle = "Chả giò ngày mưa - Cách sinh viên nấu ăn"
        video2.chanel = chanel
        video2.videoSubtitle = "\((video2.chanel?.chanelName)!) · 65K views · 1 year ago"
        video2.videoImageName = "thumbnailVideoImage2"
        
        return [video1, video2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "CellId")
        // Fix collectionView under menuBar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        
        setupMenuBar()
        setupNavbaButtonItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let selectedIndexpath = IndexPath(item: 0, section: 0)
        menuBar.collectionView.selectItem(at: selectedIndexpath, animated: false, scrollPosition: [])
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    func setupNavbaButtonItems() {
        let searchButtonImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchButtonItem = UIBarButtonItem(image: searchButtonImage, style: .plain, target: self, action: #selector(handleSearchButton))
        
        let moreButtonImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreButtonImage, style: .plain, target: self, action: #selector(handleMoreButton))
        
        navigationItem.rightBarButtonItems = [moreButtonItem, searchButtonItem]
    }
    
    func handleSearchButton() {
        print("search button pressed")
    }
    
    func handleMoreButton() {
        print("More button pressed")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 94)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

}

