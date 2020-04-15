//
//  Auth.swift
//  geoTwitter
//
//  Created by Niko Holopainen on 15.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation
import OAuthSwift

class Auth {
    
    var oAuth: OAuth1Swift?
    
    func authUserToken() {
        // Create an instance and retain it
        oAuth = OAuth1Swift(
            consumerKey:    Keys.consumerKey.rawValue,
            consumerSecret: Keys.consumerSecret.rawValue,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        
        // Authorize
        oAuth?.authorize(
        withCallbackURL: URL(string: "fi.metropolia.geoTwitter://")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
                // Append user token & secret to user default
                let userData = UserDefaults.standard
                userData.setValue(credential.oauthToken, forKey: "userToken")
                userData.setValue(credential.oauthTokenSecret, forKey: "userSecret")
                print("userToken: \(userData.value(forKey: "userToken") ?? "Error")")
                print("userSecret: \(userData.value(forKey: "userSecret") ?? "Error")")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
