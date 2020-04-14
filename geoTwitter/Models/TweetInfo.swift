//
//  TweetInfo.swift
//  geoTwitter
//
//  Created by iosdev on 14.4.2020.
//  Copyright © 2020 Daniel Finnerman. All rights reserved.
//

import Foundation

struct SingleTweet: Codable {
    
    let createdAt: String
    let id: Double
    let idStr, text: String
    let source: String
    let user: User
    let geo, coordinates: Double
    let place: GeoLocation
    let retweetCount, favoriteCount: Int
    let favorited, retweeted: Bool

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case text, source
        case idStr = "id_str"
        case user, geo, coordinates, place
        case retweetCount = "retweet_count"
        case favoriteCount = "favorite_count"
        case favorited, retweeted
    }
}

struct URLs: Codable {
    let url, expandedURL, displayURL, mediaURL, mediaURLHTTPS: String

    enum CodingKeys: String, CodingKey {
        case url
        case expandedURL = "expanded_url"
        case displayURL = "display_url"
        case mediaURL = "media_url"
        case mediaURLHTTPS = "media_url_https"
        
    }
}


struct GeoLocation: Codable {
    let id: String
    let url: String
    let placeType, name, fullName, countryCode: String
    let country: String
    let boundingBox: BoundingBox

    enum CodingKeys: String, CodingKey {
        case id, url
        case placeType = "place_type"
        case name
        case fullName = "full_name"
        case countryCode = "country_code"
        case country
        case boundingBox = "bounding_box"
    }
}


struct BoundingBox: Codable {
    let type: String
    let coordinates: [[[Double]]]
}

struct User: Codable {
    let id: Double
    let idStr, name, screenName, location: String
    let createdAt: String
    let favouritesCount: Int
    let geoEnabled, verified: Bool
    let profileImageURL: String
    let profileImageURLHTTPS: String
    let defaultProfile, defaultProfileImage: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case idStr = "id_str"
        case name
        case verified
        case screenName = "screen_name"
        case location
        case createdAt = "created_at"
        case favouritesCount = "favourites_count"
        case geoEnabled = "geo_enabled"
        case profileImageURL = "profile_image_url"
        case profileImageURLHTTPS = "profile_image_url_https"
        case defaultProfile = "default_profile"
        case defaultProfileImage = "default_profile_image"
    }
}

// sit pitäs kyhää entities tänne ja survoo niit ylös

