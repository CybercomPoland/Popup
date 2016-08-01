//
//  ViewController.swift
//  Popup
//
//  Created by Michal Zietera on 25.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PopupShowable {
    let popupTransitionHandler = TransitionHandler()

    @IBAction func showPresenterPopup(sender: UIButton) {
        showPopupWithTitle("The value provided by the presentation controller’s delegate or UIModalPresentationNone if a delegate was not provided or does not return a valid value. ", andSubtitle: "After the content managed by the presentation controller is onscreen, this method returns the presentation style to use when transitioning to a horizontally compact environment. This method is not meant to be overridden. The implementation consults its delegate object and returns the value provided by that object’s adaptivePresentationStyleForPresentationController: method. Some system-supplied presentation controllers may also provide a new style that is more suited for a compact environment. For example, presentation controllers that manage popovers and form sheets return the UIModalPresentationFullScreen value.",
                           andActions: [
                            PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                                self.dismissViewControllerAnimated(true, completion: {
                                    print("done first action")
                                })
                            }),
                            PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                                print("done second action")
                            })
                        ],
                           dismissable: false, animated: true, completion: nil)
        
    }
    
    @IBAction func showAlertView(sender: AnyObject) {
        showPopupWithTitle("Test",
                           andSubtitle: "Test",
                           andActions: [
            PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                print("done first action")
            }),
            PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                print("done second action")
            })
            ],
                           dismissable: true,
                           animated: true, completion: nil)
    }
    
    @IBAction func showWithHeaderView(sender: UIButton) {
        let headerView = NSBundle.mainBundle().loadNibNamed("exampleview", owner: self, options: nil).first as! UIView

        showPopupWithHeader(headerView,
                            andActions:
            [
                PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                                print("done first action")
                            }),
                            PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                                print("done second action")
                            })
            ],
                            dismissable: true, animated: true, completion: nil)
    }
}

