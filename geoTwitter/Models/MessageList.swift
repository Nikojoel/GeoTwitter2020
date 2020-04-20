//
//  MessageList.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation

struct MessageList: Codable {
    let next_curson: String
    let events: [Events]
}

struct Events: Codable {
    let id: Int
    let created_timestamp: String
}
