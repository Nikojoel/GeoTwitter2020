
import Foundation
import RxSwift
/**
 Class for fetching twitter api
 - searchTweet: standanrd query search
 - myAccount: returns account for the current authenticated user
 - listDirectMessages: return a list of direct messages
 - showDirectMessage: shows a message based of id
 - showUser: show a user by id
 - postDirectMessage: send a new private message
 - postTweet: post a new tweet from logged in user
 - getTrends: gets the trending topics based of device location
 - getClosestWoeId: get the woeid based of device location
 */
class TwitterApi {
    private let networkService = NetworkService()
    private let baseURL = EndPoint.url.rawValue
    /**
     Creates a api standard api query for tweets
     - Parameters:
        - query: string or a hashtah to search
        - count: number of tweets to return 100max
        - lang: Best guess language EN defautl
        - type: Type of return mixed, popular, recent
     - Returns: an Observable typed TweetQuery
     */
    func searchTweet(_ query: String, count: Int = 100, lang: String = "en", type: String = "mixed") -> Observable<TweetQuery> {
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = baseURL + EndPoint.query.rawValue + "?q=\(queryEncoded ?? "")&count=\(count)&lang=\(lang)&type=\(type)"
        return networkService.requestGET(url: url)
    }
    /**
    Creates an api standard api query for next tweet results
     - Returns: an Observable typed TweetQuery
     */
    func searchNextTweet(_ query: String) -> Observable<TweetQuery> {
        let url = EndPoint.url.rawValue + EndPoint.query.rawValue + query
        return networkService.requestGET(url: url)
    }
    /**
    Fetches current acoounts info form twitter
     - Returns: Observable typed Account
     */
    func myAccount() -> Observable<Account> {
        return networkService.requestGET(url: baseURL + EndPoint.account.rawValue)
    }
    /**
     List direct messages of the user
     - Returns: Observable type MessageList
     */
    func listDirectMessages() -> Observable<MessageList> {
        return networkService.requestGET(url: baseURL + EndPoint.listDirectMessages.rawValue)
    }
    /**
     Show a single direct message
     - Returns: Observable type DirectMessage
     */
    func showDirectMessage(id: Int) -> Observable<DirectMessage> {
        return networkService.requestGET(url: baseURL + EndPoint.showDirectMessage.rawValue + "?id=\(id)")
    }
    /**
     Show a single user based of id
     - Returns: Observabkle type Account
     */
    func showUser(id: String) -> Observable<Account> {
        return networkService.requestGET(url: baseURL + EndPoint.showUser.rawValue + "?id=\(id)")
    }
    /**
     Send a direct message to a user
     - Parameters:
        - id: String of receiver is
        - message: Message string
     */
    func postDirectMessage(id: String, message: String) {
        let data = "{\"event\": {\"type\": \"message_create\", \"message_create\": {\"target\": {\"recipient_id\": \"\(id)\"}, \"message_data\": {\"text\": \"\(message)\"}}}}"
        let header = ["Content-Type":"application/json"]
        networkService.requestPOST(url: baseURL + EndPoint.newMessage.rawValue, body: data, headers: header)
    }
    /**
     Post a new tweet from logged in user
     Message will be percentencoded.
     - Parameters:
        - message: message string
     */
    func postTweet(message: String) {
        let encoded = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        networkService.requestPOST(url: baseURL + EndPoint.newTweet.rawValue + "?status=\(encoded ?? "")", body: "")
    }
    /**
     Get trending topics.
     - Parameters:
        - id: woeid as a string(1 for global default)
     */
    func getTrends(id: String = "1") -> Observable<[TrendQuery]> {
        return networkService.requestGET(url: baseURL + EndPoint.getTrends.rawValue + "?id=\(id)")
    }
    /**
     Get woeid closest to device location
     - Parameters:
        - lat: latitude double
        - long: longitude double
     */
    func getClosesWoeId(lat: Double, long: Double) -> Observable<[WoeId]> {
        return networkService.requestGET(url: baseURL + EndPoint.getClosestWOEID.rawValue + "?lat=\(lat)&long=\(long)")
    }
}
