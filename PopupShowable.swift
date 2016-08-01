//
//  PopupShowable.swift
//  Popup
//
//  Created by Michal Zietera on 01.08.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import Foundation
import UIKit

protocol PopupShowable {
    var popupTransitionHandler: TransitionHandler { get }
}

extension PopupShowable where Self: UIViewController {
    func showPopupWithTitle(title: String, andSubtitle subtitle: String, andActions actions: [PopupAction], dismissable: Bool = true, animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = GenericPopupViewController(title: title, subtitle: subtitle, actions: actions, transitioningDelegate: popupTransitionHandler, dismissable: dismissable)
        presentViewController(controller, animated: animated, completion: completion)
    }
    
    func showPopupWithHeader(headerView: UIView, andActions actions: [PopupAction], dismissable: Bool = true, animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = GenericPopupViewController(headerView: headerView, actions: actions, transitioningDelegate: popupTransitionHandler, dismissable: dismissable)
        presentViewController(controller, animated: animated, completion: completion)
    }
}