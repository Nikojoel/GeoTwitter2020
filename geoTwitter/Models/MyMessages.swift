//
//  MessageList.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation

class MyMessages {
    
    var account: Account
    var messages: [Event] = []
    
    init(account: Account) {
        self.account = account
    }
    
}
