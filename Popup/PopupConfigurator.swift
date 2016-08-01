//
//  PopupConfigurator.swift
//  Popup
//
//  Created by Michal Zietera on 01.08.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class PopupConfigurator<Button: UIButton>{
    //static let sharedPopupConfigurator = PopupConfigurator()
    
    private var buttonConfigurator: ((button: Button) -> ())? = nil
    
    func setConfiguration(buttonConfigurator: ((button: Button) -> ())? = nil) {
        self.buttonConfigurator = buttonConfigurator
    }
}