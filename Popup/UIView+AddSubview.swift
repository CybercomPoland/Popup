//
//  UIView+AddSubview.swift
//  Popup
//
//  Created by Michal Zietera on 26.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

extension UIView {
    func addSubview(subview: UIView, underView: UIView?, isLastOne: Bool) {
        addSubview(subview)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(margin)-[subview]-(margin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": 8], views: ["subview" : subview]))
        if let underView = underView {
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[underView]-(margin)-[subview]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": 8], views: ["underView": underView, "subview": subview]))
        } else {
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(margin)-[subview]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": 8], views: ["subview": subview]))
        }
        
        if(isLastOne) {
            addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: subview, attribute: .Bottom, multiplier: 1.0, constant: 8.0))
        }
    }
}