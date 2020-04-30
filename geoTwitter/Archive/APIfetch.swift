//
//  APIfetch2.swift
//  geoTwitter
//
//  Created by iosdev on 16.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//
//import Foundation
//import OAuthSwift
//import RxSwift
//
//
//class APIFetch {
//    private var oauth: OAuth1Swift?
//    let subject = PublishSubject<TweetQuery>()
//    
//    func fetchAPI(query: String?) {
//        let userData = UserDefaults.standard
//        let urlEncoded = query?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        guard let userToken = userData.string(forKey: "userToken"),
//            let userSecret = userData.string(forKey: "userSecret") else { return }
//        
//        oauth = OAuth1Swift (
//            consumerKey:    Keys.consumerKey.rawValue,
//            consumerSecret: Keys.consumerSecret.rawValue,
//            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
//            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
//            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
//        )
//        oauth?.client.credential.oauthToken = userToken
//        oauth?.client.credential.oauthTokenSecret = userSecret
//        
//        oauth?.client.get("https://api.twitter.com/1.1/search/tweets.json?q=\(urlEncoded ?? "")&count=100") { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let decoder = JSONDecoder()
//                    let tweet = try decoder.decode(TweetQuery.self, from: response.data)
//                    self.subject.onNext(tweet)
//                    
//                } catch let error {
//                    print("decoding error", error)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    
//}
