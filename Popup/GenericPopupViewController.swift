//
//  GenericPopupViewController.swift
//  Popup
//
//  Created by Michal Zietera on 26.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class GenericPopupViewController: UIViewController {
    
    private var container = UIView()
    private var upperView = UIScrollView()
    private var upperContainerView = UIView()
    private var lowerView = UIView()
    private var actions: [PopupAction]!
    
    convenience init(title: String, subtitle: String, actions: [PopupAction]) {
        self.init()
        setupBasicView()
        self.actions = actions
        upperContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel(frame: CGRectZero)
        titleLabel.text = title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        
        let subtitleLabel = UILabel(frame: CGRectZero)
        subtitleLabel.text = subtitle
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .Center
        
        upperContainerView.addSubview(titleLabel, underView: nil, isLastOne: false)
        upperContainerView.addSubview(subtitleLabel, underView: titleLabel, isLastOne: true)
        
        upperView.addSubviewAndFill(upperContainerView)
        upperView.addConstraint(NSLayoutConstraint(item: upperContainerView, attribute: .Width, relatedBy: .Equal, toItem: upperView, attribute: .Width, multiplier: 1, constant: 0))
        
        var previousButton: UIButton? = nil
        for (index, action) in actions.enumerate() {
            let button = UIButton(type: .System)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = action.color
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTapped(_:)), forControlEvents: .TouchUpInside)
            button.setTitle(action.title, forState: .Normal)
            
            let isLastOne = index == (actions.count - 1)
            lowerView.addSubview(button, underView: previousButton, isLastOne: isLastOne)
            previousButton = button
        }
        
        let newSize = view.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        view.bounds.size = newSize

        view.layoutIfNeeded()
    }
    
    convenience init(headerView: UIView, actions: [PopupAction]) {
        self.init()
        setupBasicView()
    }
    
    private func setupBasicView() {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width * 0.9)
        let height: CGFloat = (UIScreen.mainScreen().bounds.height * 0.9)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviewAndFill(container)
       
        container.addSubview(upperView, underView: nil, isLastOne: false)
        container.addSubview(lowerView, underView: upperView, isLastOne: true)
        
        upperView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false
       
        let heightConstraint = NSLayoutConstraint(item: upperView, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: height)
        upperView.addConstraint(heightConstraint)
        
        container.addConstraint(NSLayoutConstraint(item: container, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width))
        container.addConstraint(NSLayoutConstraint(item: container, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height))

        upperView.backgroundColor = UIColor.redColor()
        lowerView.backgroundColor = UIColor.blueColor()
        view.backgroundColor = UIColor.brownColor()
    }
    
    func handleButtonTapped(button: UIButton) {
        actions[button.tag].action()
    }
}
