//
//  SetupLauncher.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 7/3/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class SetupLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override init() {
        super.init()
        self.setup()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "setting"), Setting(name: "Term & pricacy policy", imageName: "privacy"), Setting(name: "Send Feedback", imageName: "feedback"), Setting(name: "Help", imageName: "help"), Setting(name: "Switch Account", imageName: "account"), Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    var yCollectionView: CGFloat?
    var heightCollectionView: CGFloat = 300
    
    let collectionCellHeight: CGFloat = 50
    let cellID = "CellID"
    
    let blackView = UIView()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.row]
        return cell
    }
    
    private func setup() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            yCollectionView = window.frame.height - heightCollectionView
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heightCollectionView)
        }
    }
    
    @objc private func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.yCollectionView! + self.heightCollectionView, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }, completion: nil)
    }
    
    func show() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.blackView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: self.yCollectionView!, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }, completion: nil)
    }
}
