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

//    let presenter: Presentr = {
//        let presenter = Presentr(presentationType: .Alert)
//        presenter.transitionType = TransitionType.CoverHorizontalFromRight
//        return presenter
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showPresenterPopup(sender: UIButton) {
        //let controller = storyboard?.instantiateViewControllerWithIdentifier("Popup") as! PopupViewController
        let controller = GenericPopupViewController(title: "The value provided by the presentation controller’s delegate or UIModalPresentationNone if a delegate was not provided or does not return a valid value. ", subtitle: "After the content managed by the presentation controller is onscreen, this method returns the presentation style to use when transitioning to a horizontally compact environment. This method is not meant to be overridden. The implementation consults its delegate object and returns the value provided by that object’s adaptivePresentationStyleForPresentationController: method. Some system-supplied presentation controllers may also provide a new style that is more suited for a compact environment. For example, presentation controllers that manage popovers and form sheets return the UIModalPresentationFullScreen value.", actions:
            [
                PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                print("done first action")
                }),
                PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                    print("done second action")
                })
            ])
        //let controller = GenericPopupViewController(title: "", subtitle: "", actions: [])

        controller.transitioningDelegate = transitionHandler
        controller.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(controller, animated: true, completion: nil)
//        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
        
    }
    @IBAction func showAlertView(sender: AnyObject) {
        //let controller = storyboard?.instantiateViewControllerWithIdentifier("Popup") as! PopupViewController
        let controller = GenericPopupViewController(title: "Test", subtitle: "Test", actions:
            [
                PopupAction(title: "Tap on me", color: UIColor.redColor(), action: {
                    print("done first action")
                }),
                PopupAction(title: "Tap on me too", color: UIColor.greenColor(), action: {
                    print("done second action")
                })
            ])
        //let controller = GenericPopupViewController(title: "", subtitle: "", actions: [])
        
        controller.transitioningDelegate = transitionHandler
        controller.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(controller, animated: true, completion: nil)
        //        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
        
    }
}

