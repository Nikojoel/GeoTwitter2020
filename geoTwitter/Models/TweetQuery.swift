//
//  Tweet.swift
//  geoTwitter
//
//  Created by iosdev on 15.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation

struct TweetQuery: Codable {
    let tweet: [Tweet]
    let metaData: MetaData
    
    enum CodingKeys: String, CodingKey {
        case tweet = "statuses"
        case metaData = "search_metadata"
    }
}

struct Tweet:Codable {
    let created_at: String
    let id: Int
    let text: String
    let user: User
    let geo: Geo?
    let coordinates: Coordinates?
    let place: Place?
    let retweet_count: Int
    let favorite_count: Int
    let favorited: Bool
    let retweeted: Bool
    let lang: String
}

struct MetaData: Codable {
    let next_results: String
    let query: String
    let count: Int
    
}

struct Geo:Codable {
    let coordinates: [Double]
}

struct Coordinates:Codable {
    let coordinates: [Double]
}

struct User: Codable {
    let id: Int
    let name: String
    let screen_name: String
    let location: String
    let description: String
    let followers_count: Int
    let friends_count: Int
    let favourites_count: Int
    let profile_background_image_url_https: String?
    let profile_image_url_https: String?
}

struct Place: Codable {
    let id: String?
    let url: String?
    let place_type: String?
    let name: String?
    let country: String?
}
