//
//  NetworkService.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation
import OAuthSwift
import RxSwift

class NetworkService {
    private var oauth: OAuth1Swift?
    
    init() {
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
        
    }
    
    func requestGET<T:Decodable>(url: String) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            self.oauth?.client.get(url) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(T.self, from: response.data)
                        observer.onNext(decoded)
                        observer.onCompleted()
                    } catch let error {
                        print("decoding error", error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create {
                print("disposable created")
            }
        }
    }
    
    
    func requestPOST<T: Decodable>(url: String, parameters: [String:Any] = [:], headers: [String:String] = [:] ) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            self.oauth?.client.request(url, method: .POST, parameters: parameters, headers: headers) { result in
                
            }
            
            return Disposables.create {
                print("disposable created")
            }
        }
        
        
    }
    
    
}
