//
//  APIfetchT.swift
//  geoTwitter
//
//  Created by iosdev on 23.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation
import OAuthSwift
import RxSwift
class APIFetchT {
    private var oauth: OAuth1Swift?
    let subject = PublishSubject<TrendQuery>()
    
    func fetchAPI() {
        let userData = UserDefaults.standard
        
        guard let userToken = userData.string(forKey: "userToken"),
            let userSecret = userData.string(forKey: "userSecret") else { return }
        
        oauth = OAuth1Swift (
            consumerKey:    Keys.consumerKey.rawValue,
            consumerSecret: Keys.consumerSecret.rawValue,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        oauth?.client.credential.oauthToken = userToken
        oauth?.client.credential.oauthTokenSecret = userSecret
        
        oauth?.client.get("https://api.twitter.com/1.1/trends/place.json?id=1") { result in
            switch result {
            case .success(let response):
                do {
                    guard let jesonString = String(bytes: response.data, encoding: .utf8) else{
                        return
                    }
                    let jeson = jesonString.dropFirst().dropLast()
                    print(jeson)
                    guard let jesonData = jeson.data(using: .utf8) else{
                        return
                    }
                    let decoder = JSONDecoder()
                    let trend = try decoder.decode(TrendQuery.self, from: jesonData)
                    self.subject.onNext(trend)
                    print("trend")
                    
                } catch let error {
                    print("decoding error", error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
