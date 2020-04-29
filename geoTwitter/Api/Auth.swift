//
//  Auth2.swift
//  geoTwitter
//
//  Created by iosdev on 16.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//
import Foundation
import OAuthSwift
import RxSwift

class Auth {
    
    private var oAuth: OAuth1Swift?
    
    func authUserToken() -> Observable<Bool> {
        // Create an instance and retain it
        return Observable.create { observer -> Disposable in
            
            self.oAuth = OAuth1Swift(
                consumerKey:    Keys.consumerKey.rawValue,
                consumerSecret: Keys.consumerSecret.rawValue,
                requestTokenUrl: "https://api.twitter.com/oauth/request_token",
                authorizeUrl:    "https://api.twitter.com/oauth/authorize",
                accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
            )
            
            // Authorize
            self.oAuth?.authorize(
            withCallbackURL: URL(string: "fi.metropolia.geoTwitter://")!) { result in
                switch result {
                case .success(let (credential, _, _)):
                    // Append user token & secret to user default
                    let userData = UserDefaults.standard
                    userData.setValue(credential.oauthToken, forKey: "userToken")
                    userData.setValue(credential.oauthTokenSecret, forKey: "userSecret")
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                    print(error.localizedDescription)
                    
                }
            }
            return Disposables.create {
                
            }
            
        }
        
    }
}
