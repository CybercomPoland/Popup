//
//  GenericPopupViewController.swift
//  Popup
//
//  Created by Michal Zietera on 26.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class GenericPopupViewController: UIViewController {
    
    private var mainContainer = UIView()
    private var scrollView = UIScrollView()
    private var scrollViewContentContainer = UIView()
    private var buttonsContainer = UIView()
    private var actions: [PopupAction]!
    
    convenience init(title: String, subtitle: String, actions: [PopupAction]) {
        self.init()
        setupBasicView()
        self.actions = actions
        scrollViewContentContainer.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        scrollViewContentContainer.addSubview(titleLabel, underView: nil, isLastOne: false)
        scrollViewContentContainer.addSubview(subtitleLabel, underView: titleLabel, isLastOne: true)
        
        scrollView.addSubviewAndFill(scrollViewContentContainer)
        scrollView.addConstraint(NSLayoutConstraint(item: scrollViewContentContainer, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant: 0))
        
        let size = scrollViewContentContainer.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let heightConstraint = NSLayoutConstraint(item: scrollView, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: size.height)
        scrollView.addConstraint(heightConstraint)

        var previousButton: UIButton? = nil
        for (index, action) in actions.enumerate() {
            let button = UIButton(type: .System)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = action.color
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTapped(_:)), forControlEvents: .TouchUpInside)
            button.setTitle(action.title, forState: .Normal)
            
            let isLastOne = index == (actions.count - 1)
            buttonsContainer.addSubview(button, underView: previousButton, isLastOne: isLastOne)
            previousButton = button
        }
        
        let newSize = view.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        view.bounds.size = newSize

        view.layoutIfNeeded()
    }
    
    convenience init(headerView: UIView, actions: [PopupAction]) {
        self.init()
        setupBasicView()
        self.actions = actions
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.bounds.size = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        scrollViewContentContainer.addSubviewAndFill(headerView)
        scrollView.addSubviewAndFill(scrollViewContentContainer)
        scrollView.addConstraint(NSLayoutConstraint(item: scrollViewContentContainer, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant: 0))
        let size = scrollViewContentContainer.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        let heightConstraint = NSLayoutConstraint(item: scrollView, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: size.height)
        scrollView.addConstraint(heightConstraint)
        
        var previousButton: UIButton? = nil
        for (index, action) in actions.enumerate() {
            let button = UIButton(type: .System)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = action.color
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTapped(_:)), forControlEvents: .TouchUpInside)
            button.setTitle(action.title, forState: .Normal)
            
            let isLastOne = index == (actions.count - 1)
            buttonsContainer.addSubview(button, underView: previousButton, isLastOne: isLastOne)
            previousButton = button
        }

        let newSize = view.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        view.bounds.size = newSize
        
        view.layoutIfNeeded()
    }
    
    private func setupBasicView() {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width * 0.9)
        let height: CGFloat = (UIScreen.mainScreen().bounds.height * 0.9)
        
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviewAndFill(mainContainer)
       
        mainContainer.addSubview(scrollView, underView: nil, isLastOne: false)
        mainContainer.addSubview(buttonsContainer, underView: scrollView, isLastOne: true)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        mainContainer.addConstraint(NSLayoutConstraint(item: mainContainer, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width))
        mainContainer.addConstraint(NSLayoutConstraint(item: mainContainer, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height))

        scrollView.backgroundColor = UIColor.redColor()
        buttonsContainer.backgroundColor = UIColor.blueColor()
        view.backgroundColor = UIColor.brownColor()
    }
    
    func handleButtonTapped(button: UIButton) {
        actions[button.tag].action()
    }
}
