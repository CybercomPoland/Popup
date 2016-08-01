//
//  TransitionHandler.swift
//  Popup
//
//  Created by Michal Zietera on 25.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import Foundation
import UIKit

class TransitionHandler: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var popupShouldBeDismissable = true
    
    private var transitionDuration = 1.0
    private var presenting = false
    private var transitionAnimation: ((context: UIViewControllerContextTransitioning, presenting: Bool, duration: NSTimeInterval) -> Void)
    
    override init() {
        transitionAnimation = {(context: UIViewControllerContextTransitioning, Bool, NSTimeInterval) in }
    }
    
    convenience init(transitionAnimation: ((transitionContext: UIViewControllerContextTransitioning, presenting: Bool, duration: NSTimeInterval) -> Void), withDuration duration: NSTimeInterval) {
        self.init()
        self.transitionAnimation = transitionAnimation
        self.transitionDuration = duration
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presentingViewController: presenting, popupDismissable: popupShouldBeDismissable)
        return presentationController
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        transitionAnimation(context: transitionContext, presenting: presenting, duration: transitionDuration(transitionContext))
    }
}
