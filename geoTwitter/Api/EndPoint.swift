//
//  EndPoint.swift
//  geoTwitter
//
//  Created by iosdev on 19.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

enum EndPoint: String {
    case url = "https://api.twitter.com/1.1/"
    case account = "account/verify_credentials.json"
    case query = "search/tweets.json"
    case newMessage = "direct_messages/events/new.json"
    case listDirectMessages = "direct_messages/events/list.json"
    case showDirectMessage = "direct_messages/events/show.json"
    case getClosestWOEID = "trends/closest.json"
    case getTrends = "trends/place.json"
    case newTweet = "statuses/update.json"
    case deleteTweet = "statuses/destroy/" //:id.json
    case likeTweet = "favorites/create.json"
    case deleteLike = "favorites/destroy.json"
}
