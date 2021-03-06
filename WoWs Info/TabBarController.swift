//
//  TabBarController.swift
//  WoWs Info
//
//  Created by Henry Quan on 27/4/17.
//  Copyright © 2017 Henry Quan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    static var index = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        // Search
        self.selectedIndex = TabBarController.index
        // ThemeColour
        self.tabBar.tintColor = Theme.getCurrTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
