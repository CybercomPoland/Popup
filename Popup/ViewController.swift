//
//  ViewController.swift
//  Popup
//
//  Created by Michal Zietera on 25.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit
import Presentr

class ViewController: UIViewController {
    
    let transitionHandler = TransitionHandler(transitionAnimation: TransitionFactory().getTransitionAnimation(.SlideFromBottom), withDuration: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showPresenterPopup(sender: UIButton) {
        let controller = GenericPopupViewController(title: "The value provided by the presentation controller’s delegate or UIModalPresentationNone if a delegate was not provided or does not return a valid value. ", subtitle: "After the content managed by the presentation controller is onscreen, this method returns the presentation style to use when transitioning to a horizontally compact environment. This method is not meant to be overridden. The implementation consults its delegate object and returns the value provided by that object’s adaptivePresentationStyleForPresentationController: method. Some system-supplied presentation controllers may also provide a new style that is more suited for a compact environment. For example, presentation controllers that manage popovers and form sheets return the UIModalPresentationFullScreen value.", actions:
            [
                PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                    self.dismissViewControllerAnimated(true, completion: {
                        print("done first action")
                    })
                }),
                PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                    print("done second action")
                })
            ],
                                                    transitioningDelegate: transitionHandler,
                                                    dismissable: false)
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    @IBAction func showAlertView(sender: AnyObject) {
        let controller = GenericPopupViewController(title: "Test", subtitle: "Test", actions:
            [
                PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                    print("done first action")
                }),
                PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                    print("done second action")
                })
            ],
                                                    transitioningDelegate: transitionHandler,
                                                    dismissable: false)
        controller.dismissable = true
        presentViewController(controller, animated: true, completion: nil)
        
    }
    @IBAction func showWithHeaderView(sender: UIButton) {
        //let headerView = storyboard!.instantiateViewControllerWithIdentifier("Popup").view
        let headerView = NSBundle.mainBundle().loadNibNamed("exampleview", owner: self, options: nil).first as! UIView
        let controller = GenericPopupViewController(headerView: headerView, actions: [
            PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                print("done first action")
            }),
            PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                print("done second action")
            })
            ],
                                                    transitioningDelegate: transitionHandler,
                                                    dismissable: false
        )
        presentViewController(controller, animated: true, completion: nil)
    }
}

