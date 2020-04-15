//
//  ViewController.swift
//  geoTwitter
//
//  Created by iosdev on 7.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    

    var tweets: [TweetQuery] = [] {
        didSet {
            for tweet in tweets {
                print(tweet.tweet.count)
            }
            
        }
    }
    let api = APIFetch()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // rxswift subscription example
        //        api.subject
        //            .subscribe {
        //                if let element = $0.element {
        //                    self.tweets.append(element)
        //                }
        //        }
        //        api.fetchAPI(query: "#helsinki")
        //    }
        
        //auth.authUserToken()
        

    //var auth = Auth()
    
    
}

