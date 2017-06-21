//
//  extension.swift
//  Youtube-app
//
//  Created by ScofieldNguyen on 6/17/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintWithFormat(format: String, views: UIView...) {
        var dictionaryViews = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            dictionaryViews[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionaryViews))
    }
}
