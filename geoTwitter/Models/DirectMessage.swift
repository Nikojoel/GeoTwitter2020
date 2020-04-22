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

struct Event: Codable, Hashable {
    let id: String
    let created_timestamp: String
    let type: String
    let message_create: Message
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Message: Codable {
    let sender_id: String
    let message_data: MessageData
}

struct MessageData: Codable {
    let text: String
}
