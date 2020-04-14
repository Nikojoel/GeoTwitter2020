//
//  APIfetc.swift
//  geoTwitter
//
//  Created by iosdev on 14.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//
// testiii
import Foundation
import OAuthSwift

class APIFetch {
    private var oauth: OAuth1Swift?
    
    func fetchAPI(query: String?) {
        
        let urlEncoded = query?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        oauth = OAuth1Swift (
            consumerKey:    HardCodedKeys.consumerKey.rawValue,
            consumerSecret: HardCodedKeys.consumerSecret.rawValue,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        oauth?.client.credential.oauthToken = HardCodedKeys.userToken.rawValue
        oauth?.client.credential.oauthTokenSecret = HardCodedKeys.userSecret.rawValue
        
        oauth?.client.get("https://api.twitter.com/1.1/search/tweets.json?q=\(urlEncoded ?? "")") { result in
            switch result {
            case .success(let response):
                let dataString = response.string
                print(dataString ?? "no data string")
                
                // TODO decoding to json data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}


