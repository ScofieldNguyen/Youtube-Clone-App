//
//  SettingCell.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 7/4/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class Setting: NSObject {
    var name: SettingName?
    var imageName: String?
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class SettingCell: BaseClass {
    
    var setting: Setting? {
        didSet{
            if let name = setting?.name, let imageName = setting?.imageName {
                settingLabel.text = name.rawValue
                settingIcon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            self.backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            settingLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            settingIcon.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 104, green: 104, blue: 105)
        }
    }
    
    let settingIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.tintColor = UIColor.rgb(red: 104, green: 104, blue: 105)
        return iv
    }()
    
    let settingLabel: UILabel = {
        let lv = UILabel()
//        lv.backgroundColor = UIColor.black
        lv.text = "Settings"
        lv.font = UIFont.systemFont(ofSize: 13)
        return lv
    }()
    
    override func setupViews() {
        addSubview(settingIcon)
        addSubview(settingLabel)
        
        addConstraintWithFormat(format: "H:|-8-[v0(20)]-16-[v1]|", views: settingIcon,settingLabel)
        addConstraintWithFormat(format: "V:[v0(20)]", views: settingIcon)
        addConstraintWithFormat(format: "V:|[v0]|", views: settingLabel)
        
        addConstraint(NSLayoutConstraint(item: settingIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
