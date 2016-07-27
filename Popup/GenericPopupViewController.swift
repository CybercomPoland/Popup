//
//  GenericPopupViewController.swift
//  Popup
//
//  Created by Michal Zietera on 26.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class GenericPopupViewController: UIViewController {
    
    private var upperView = UIView()
    private var lowerView = UIView()
    private var actions: [PopupAction]!
    
    convenience init(title: String, subtitle: String, actions: [PopupAction]) {
        self.init()
        setupBasicView()
        self.actions = actions
        
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
        
        upperView.addSubview(titleLabel, underView: nil, isLastOne: false)
        upperView.addSubview(subtitleLabel, underView: titleLabel, isLastOne: true)
        
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

    }
    
    convenience init(headerView: UIView, actions: [PopupAction]) {
        self.init()
        setupBasicView()
    }
    
    private func setupBasicView() {
        let width = UIScreen.mainScreen().bounds.width * 0.9

        view.addSubview(upperView, underView: nil, isLastOne: false)
        view.addSubview(lowerView, underView: upperView, isLastOne: true)
        
        upperView.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false

        ///
        //upperView.addConstraint(NSLayoutConstraint(item: upperView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100.0))
        //lowerView.addConstraint(NSLayoutConstraint(item: lowerView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 100.0))
        ///
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width))
        
        upperView.backgroundColor = UIColor.redColor()
        lowerView.backgroundColor = UIColor.blueColor()
        view.backgroundColor = UIColor.brownColor()
    }
    
    func handleButtonTapped(button: UIButton) {
        actions[button.tag].action()
    }
}
