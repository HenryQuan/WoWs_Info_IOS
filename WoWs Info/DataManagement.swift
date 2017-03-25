//
//  DataManagement.swift
//  WoWs Info
//
//  Created by Henry Quan on 4/2/17.
//  Copyright © 2017 Henry Quan. All rights reserved.
//

import UIKit

class DataManagement {
    
    // Indicate which server user is in
    struct ServerIndex {
        static let Russia = 0
        static let Europe = 1
        static let NorthAmercia = 2
        static let Asia = 3
    }
    
    // Indicate saved data names
    struct DataName {
        static let FirstLaunch = "first_launch"
        static let SearchLimit = "search_limit"
        static let Server = "server"
        static let UserName = "username"
        static let IsThereAds = "ads"
        static let IsAdvancedUnlocked = "advancedunlocked"
        static let hasPurchased = "hasPurchased"
    }
    
}
