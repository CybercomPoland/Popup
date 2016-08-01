//
//  PresentationController.swift
//  Popup
//
//  Created by Michal Zietera on 26.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
    var chromeView = UIView()
    
    init(presentedViewController: UIViewController, presentingViewController: UIViewController, popupDismissable: Bool) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        chromeView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        chromeView.alpha = 0.0
        
        if(popupDismissable) {
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
            chromeView.addGestureRecognizer(tapGR)
        }
    }
    
    func chromeViewTapped(gesture: UIGestureRecognizer) {
        if(gesture.state == .Ended) {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        let containerBounds = containerView!.bounds
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = (containerBounds.size.width * 0.5) - (presentedViewFrame.size.width * 0.5)
        presentedViewFrame.origin.y = (containerBounds.size.height * 0.5) - (presentedViewFrame.size.height * 0.5)
        return presentedViewFrame
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let newSize = presentedViewController.view.bounds.size
        return newSize
    }
    
    override func presentationTransitionWillBegin() {
        chromeView.frame = containerView!.bounds
        chromeView.alpha = 0.0
        containerView?.insertSubview(chromeView, atIndex: 0)
        if let coordinator = presentedViewController.transitionCoordinator() {
            coordinator.animateAlongsideTransition({ (context) in
                self.chromeView.alpha = 1.0
                }, completion: nil)
        } else {
            chromeView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator() {
            coordinator.animateAlongsideTransition({ (context) in
                self.chromeView.alpha = 0.0
                }, completion: nil)
        } else {
            chromeView.alpha = 0.0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        chromeView.frame = containerView!.bounds
        presentedView()?.frame = frameOfPresentedViewInContainerView()
    }
    
    override func shouldPresentInFullscreen() -> Bool {
        return true
    }
    
    override func adaptivePresentationStyle() -> UIModalPresentationStyle {
        return .FullScreen
    }
}