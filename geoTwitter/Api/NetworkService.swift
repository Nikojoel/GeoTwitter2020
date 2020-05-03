import Foundation
import OAuthSwift
import RxSwift
/**
Network service for twitter api using oauth 1.0b.
init with Oauth1Swift and tokens from userdefaults
*/
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
    
    /**
     Get request with oauth.
     - Parameters:
        - url: string
     - Returns:
        - Generic Observable
     */
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
            return Disposables.create()
        }
    }
    
    /// Post request with oauth
    func requestPOST(url: String, body: String, parameters: [String:String] = [:], headers: [String:String] = [:] ) {
        let data = body.data(using: .ascii)
        self.oauth?.client.post(url, parameters: [:], headers: headers, body: data) { result in
            switch result {
            case .success(let success):
                print(success.response.statusCode, "SUCEESS")
            case .failure(let error):
                print("error in message sending: ", error)
            }
        }
    }
}



