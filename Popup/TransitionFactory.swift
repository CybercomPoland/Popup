//
//  TransitionFactory.swift
//  Popup
//
//  Created by Michal Zietera on 25.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import Foundation

//
//  TransitionFactory.swift
//  Manana
//
//  Created by Michal Zietera on 15/01/16.
//  Copyright © 2016 Cybercom. All rights reserved.
//

import Foundation
import UIKit

class TransitionFactory {
    
    private var containerView: UIView?
    private var fromVC: UIViewController!
    private var toVC: UIViewController!
    private var fromView: UIView!
    private var toView: UIView!
    
    enum TransitionType {
        case SlideFromBottom
    }
    
    func getTransitionAnimation(type: TransitionType) -> (context: UIViewControllerContextTransitioning, presenting: Bool, duration: NSTimeInterval) -> () {
        
        return { (context: UIViewControllerContextTransitioning, presenting: Bool, duration: NSTimeInterval) in
            self.containerView = context.containerView()
            
            self.fromVC = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
            self.fromView = self.fromVC.view
            
            self.toVC = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
            self.toView = self.toVC.view
            
            if let _ = self.containerView {
                switch(type) {
                case .SlideFromBottom:
                    self.getSlideFromBottom(context, presenting: presenting, duration: duration)
                }
            }
        }
    }
    
    private func getSlideFromBottom(context: UIViewControllerContextTransitioning, presenting: Bool, duration: NSTimeInterval) {
        
        let animatingVC = presenting ? toVC : fromVC
        let animatingView = animatingVC.view
        let underlyingVC = presenting ? fromVC : toVC
        
        if(presenting) {
            containerView?.addSubview(animatingView)
        }
        
        let finalFrameForVC = context.finalFrameForViewController(animatingVC)
        var initialFrameForVC = finalFrameForVC
        initialFrameForVC.origin.y = underlyingVC.view.bounds.height
        
        let initialFrame = presenting ? initialFrameForVC : finalFrameForVC
        let finalFrame = presenting ? finalFrameForVC : initialFrameForVC
        
        animatingView.frame = initialFrame

        UIView.animateWithDuration(duration, animations: {
            animatingView.frame = finalFrame
        }) { (value: Bool) in
            if !presenting {
                self.fromView.removeFromSuperview()
            }
            context.completeTransition(true)
        }
    }
}