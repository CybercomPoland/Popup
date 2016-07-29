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
       self.addSubview(subview, underView: underView, isLastOne: isLastOne, leftMargin: 8, rightMargin: 8, upperMargin: 8, bottomMargin: 8)
    }
    
    func addSubview(subview: UIView, underView: UIView?, isLastOne: Bool, leftMargin: CGFloat, rightMargin: CGFloat, upperMargin: CGFloat, bottomMargin: CGFloat?) {
        addSubview(subview)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(leftMargin)-[subview]-(rightMargin)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["leftMargin": leftMargin, "rightMargin": rightMargin], views: ["subview" : subview]))
        if let underView = underView {
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[underView]-(upperMargin)-[subview]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["upperMargin": upperMargin], views: ["underView": underView, "subview": subview]))
        } else {
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(upperMargin)-[subview]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["upperMargin": upperMargin], views: ["subview": subview]))
        }
        
        if(isLastOne) {
            addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: subview, attribute: .Bottom, multiplier: 1.0, constant: bottomMargin ?? 8))
        }
    }
    
    func addSubviewAndFill(subview: UIView) {
        addSubview(subview)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview" : subview]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subview" : subview]))
   }
}