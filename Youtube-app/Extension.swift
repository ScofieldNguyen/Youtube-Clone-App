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

extension UIColor {
    static func rgb(red: Float, green: Float, blue: Float) -> UIColor {
        return UIColor(colorLiteralRed: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageURLString: String?
    func loadImageFromURLString(urlString: String) {
        self.imageURLString = urlString
        
        if let img = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = img
            return
        }
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            if urlString == self.imageURLString {
                DispatchQueue.main.async {
                    let loadedImage = UIImage(data: data!)
                    imageCache.setObject(loadedImage!, forKey: NSString(string: urlString))
                    self.image = loadedImage
                }
            }
            
        }.resume()
    }
}
