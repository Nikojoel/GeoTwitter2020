//
//  TwitterApi.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation
import RxSwift

class TwitterApi {
    private let networkService = NetworkService()
    private let baseURL = EndPoint.url.rawValue
    
    func searchTweet(query: String) -> Observable<TweetQuery> {
        let url = baseURL + EndPoint.query.rawValue
        return networkService.requestGET(url: url)
    }
}
