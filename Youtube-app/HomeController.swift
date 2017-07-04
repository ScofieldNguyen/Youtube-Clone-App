//
//  ViewController.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 5/9/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    func fetchVideo() {
        
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.videoTitle = dictionary["title"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? Int
                    video.videoImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let chanel = Chanel()
                    let chanelDict = dictionary["channel"] as! [String:String]
                    chanel.chanelName = chanelDict["name"]
                    chanel.chanelImageName = chanelDict["profile_image_name"]
                    video.chanel = chanel
                    
                    video.duration = dictionary["duration"] as? Int
                    
                    self.videos?.append(video)
                }
                
                self.collectionView?.reloadData()
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideo()
        
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
    
    lazy var setupLauncher = SetupLauncher()
    
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
        setupLauncher.show()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 110)
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

