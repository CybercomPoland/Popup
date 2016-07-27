//
//  PopupAction.swift
//  Popup
//
//  Created by Michal Zietera on 26.07.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import UIKit

class PopupAction {
    var title: String
    var color: UIColor
    var action: () -> Void
    
    init(title: String, color: UIColor, action: (()->Void)) {
        self.title = title
        self.color = color
        self.action = action
    }
}