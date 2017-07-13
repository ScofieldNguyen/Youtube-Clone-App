//
//  ViewController.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 5/9/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    
    var settingTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = settingTitle
    }
    
}

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let titleString = ["Home", "Trending", "Subscription", "User"]
    var notExecuted: Bool = true
    let cellID = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
//        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        // Fix collectionView under menuBar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        // Set scroll direction to horizontal
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        // Paging flowlayout
        collectionView?.isPagingEnabled = true
        
        let titleLabel = UILabel()
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.hidesBarsOnSwipe = true
        
        setupMenuBar()
        setupNavbaButtonItems()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if notExecuted {
            let selectedIndexpath = IndexPath(item: 0, section: 0)
            menuBar.collectionView.selectItem(at: selectedIndexpath, animated: false, scrollPosition: [])
            notExecuted = false
        }
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var setupLauncher: SetupLauncher = {
        let sl = SetupLauncher()
        sl.homeController = self
        return sl
    }()
    
    let settingViewController = SettingController()
    
    private func setupMenuBar() {
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 33, blue: 23)
        
        view.addSubview(redView)
        view.addSubview(menuBar)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: redView)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupNavbaButtonItems() {
        let searchButtonImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchButtonItem = UIBarButtonItem(image: searchButtonImage, style: .plain, target: self, action: #selector(handleSearchButton))
        
        let moreButtonImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreButtonImage, style: .plain, target: self, action: #selector(handleMoreButton))
        
        navigationItem.rightBarButtonItems = [moreButtonItem, searchButtonItem]
    }
    
    func handleSearchButton() {
//        print("search button pressed")
        
    }
    
    func scrollToDirection(index i: Int) {
        let indexPath = IndexPath(item: i, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func handleMoreButton() {
        setupLauncher.show()
    }
    
    func showSettingController(setting: Setting) {
        settingViewController.settingTitle = setting.name?.rawValue
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func changeTitle(atIndex index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  " + titleString[index]
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
//        let colors: [UIColor] = [.blue, .red, .green, .gray]
//        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        menuBar.leftAnchorHorizontalView?.constant = x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        changeTitle(atIndex: Int(index))
    }
    
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

}

