//
//  TwitterApi.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//
//_ query: String, count: Int = 100, lang: String = "en", type: String = "mixed"
import Foundation
import RxSwift

class TwitterApi {
    private let networkService = NetworkService()
    private let baseURL = EndPoint.url.rawValue
    
    func searchTweet(_ query: String, count: Int = 100, lang: String = "en", type: String = "mixed") -> Observable<TweetQuery> {
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = baseURL + EndPoint.query.rawValue + "?q=\(queryEncoded ?? "")&count=\(count)&lang=\(lang)&type=\(type)"
        return networkService.requestGET(url: url)
    }
    
    func myAccount() -> Observable<Account> {
        return networkService.requestGET(url: baseURL + EndPoint.account.rawValue)
    }
    
    func listDirectMessages() -> Observable<MessageList> {
        return networkService.requestGET(url: baseURL + EndPoint.listDirectMessages.rawValue)
    }
    
    func showDirectMessage(id: Int) -> Observable<DirectMessage> {
        return networkService.requestGET(url: baseURL + EndPoint.showDirectMessage.rawValue + "?id=\(id)")
    }
    
    func showUser(id: String) -> Observable<Account> {
        return networkService.requestGET(url: baseURL + EndPoint.showUser.rawValue + "?id=\(id)")
    }
}
