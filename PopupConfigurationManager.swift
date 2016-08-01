//
//  PopupConfigurationManager.swift
//  Popup
//
//  Created by Michal Zietera on 01.08.2016.
//  Copyright © 2016 Michal Zietera. All rights reserved.
//

import Foundation

class PopupConfigurationManager {
    static let sharedConfigManager = PopupConfigurationManager()
    
    private var configurator = PopupConfigurator()
    
    //class that wraps configurator (because using generics with stored static property isn't possible yet)
}