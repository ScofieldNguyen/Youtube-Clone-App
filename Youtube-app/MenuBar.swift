//
//  MenuBar.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 6/21/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 33, blue: 23)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellID"
    
    var homeController: HomeController?
    
    let imageNames = ["home", "whathot", "subscriptions", "person"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        setupCollectionView()
        setupHorizontalView()
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    func setupHorizontalView() {
        addSubview(horizontalView)
        
        leftAnchorHorizontalView = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        leftAnchorHorizontalView?.isActive = true
        
        horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    var horizontalView: UIView = {
        let hv = UIView()
        hv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        hv.translatesAutoresizingMaskIntoConstraints = false
        return hv
    }()
    
    var leftAnchorHorizontalView: NSLayoutConstraint?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.row) * self.frame.width / 4
//        leftAnchorHorizontalView?.constant = x
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
//            self.layoutIfNeeded()
//        }, completion: nil)
//        print(index Path.row)
        homeController?.scrollToDirection(index: indexPath.row)
        homeController?.changeTitle(atIndex: indexPath.row)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuCell: BaseClass {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
