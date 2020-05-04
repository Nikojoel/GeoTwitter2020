//
//  TrendQuery.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation

struct TrendQuery: Codable {
    let trends: [Trend]
    let asOf, createdAt: String
    let locations: [Location]

    enum CodingKeys: String, CodingKey {
        case trends
        case asOf = "as_of"
        case createdAt = "created_at"
        case locations
    }
}


struct Location: Codable {
    let name: String
    let woeid: Int
}


struct Trend: Codable {
    let name: String
    let url: String
    let promotedContent: String?
    let query: String
    let tweetVolume: Int?

    enum CodingKeys: String, CodingKey {
        case name, url
        case promotedContent = "promoted_content"
        case query
        case tweetVolume = "tweet_volume"
    }
}
