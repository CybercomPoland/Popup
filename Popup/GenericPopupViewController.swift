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
    private var popupConfigurator
    
    var dismissable: Bool! {
        didSet {
            (self.transitioningDelegate as? TransitionHandler)?.popupShouldBeDismissable = dismissable
        }
    }
    
    private let maxWidth: CGFloat = (UIScreen.mainScreen().bounds.width * 0.9)
    private let maxHeight: CGFloat = (UIScreen.mainScreen().bounds.height * 0.9)
    private let cornerRadius: CGFloat = 5.0
    private let mainBackgroundColor = UIColor.whiteColor()
    
    convenience init(title: String, subtitle: String, actions: [PopupAction], transitioningDelegate: UIViewControllerTransitioningDelegate, dismissable: Bool) {
        self.init()
        self.transitioningDelegate = transitioningDelegate
        self.dismissable = dismissable
        (self.transitioningDelegate as? TransitionHandler)?.popupShouldBeDismissable = dismissable

        setupBasicView()

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

        scrollViewAndButtonsSetup(actions)
    }
    
    convenience init(headerView: UIView, actions: [PopupAction], transitioningDelegate: UIViewControllerTransitioningDelegate, dismissable: Bool) {
        self.init()
        self.transitioningDelegate = transitioningDelegate
        self.dismissable = dismissable
        (self.transitioningDelegate as? TransitionHandler)?.popupShouldBeDismissable = dismissable

        setupBasicView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollViewContentContainer.addSubviewAndFill(headerView)
        
        scrollViewAndButtonsSetup(actions)
    }
    
//    convenience init(viewController: UIViewController, actions: [PopupAction], transitioningDelegate: UIViewControllerTransitioningDelegate, dismissable: Bool) {
//        self.init()
//        self.transitioningDelegate = transitioningDelegate
//        self.dismissable = dismissable
//        (self.transitioningDelegate as? TransitionHandler)?.popupShouldBeDismissable = dismissable
//        
//        setupBasicView()
//        let container =
//        
//        scrollViewContentContainer.addSubviewAndFill(container)
//    }
    
    private func scrollViewAndButtonsSetup(actions: [PopupAction]) {
        self.actions = actions
        
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
        self.modalPresentationStyle = .Custom
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.layer.cornerRadius = cornerRadius
        mainContainer.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        scrollViewContentContainer.layer.cornerRadius = cornerRadius
        scrollViewContentContainer.clipsToBounds = true
        
        scrollViewContentContainer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubviewAndFill(mainContainer)
       
        mainContainer.addSubview(scrollView, underView: nil, isLastOne: false, leftMargin: 0, rightMargin: 0, upperMargin: 0, bottomMargin: nil)
        mainContainer.addSubview(buttonsContainer, underView: scrollView, isLastOne: true, leftMargin: 0, rightMargin: 0, upperMargin: 0, bottomMargin: 0)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        mainContainer.addConstraint(NSLayoutConstraint(item: mainContainer, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: maxWidth))
        mainContainer.addConstraint(NSLayoutConstraint(item: mainContainer, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: maxHeight))

        view.backgroundColor = mainBackgroundColor
    }
    
    func handleButtonTapped(button: UIButton) {
        actions[button.tag].action()
    }
}
