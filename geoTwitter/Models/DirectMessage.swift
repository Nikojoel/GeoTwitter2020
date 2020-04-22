//
//  DirectMessage.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation

struct MessageList: Codable {
    let next_cursor: String?
    let events: [Event]
}

struct DirectMessage: Codable {
    let event: Event
}

struct Event: Codable {
    let id: String
    let created_timestamp: String
    let type: String
    let message_create: Message
}

struct Message: Codable {
    let sender_id: String
    let message_data: MessageData
}

struct MessageData: Codable {
    let text: String
}
