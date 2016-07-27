//
//  PopupViewController.swift
//  Popup
//
//  Created by Michal Zietera on 25.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        presentingViewController?.providesPresentationContextTransitionStyle = true
//        presentingViewController?.definesPresentationContext = true
        // Do any additional setup after loading the view.
    }

    @IBAction func close(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
