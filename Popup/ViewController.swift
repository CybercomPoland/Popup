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
        let controller = GenericPopupViewController(title: "jakiś fajny długaśny tytuł sdad dsajhd i blasbalb aslb lab labs l", subtitle: "podtytuł", actions:
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

