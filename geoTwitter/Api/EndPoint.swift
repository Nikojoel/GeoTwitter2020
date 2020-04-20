/**
 Twitter API endpoints
 - url: baseurl for api
 - account: GET current account
 - query: GET query
 - newMessage: POST create new direct message
 - listDirectMessages: GET list direct messages
 - showDirectMessage: GET show direct message by id
 - getClosestWOEID: GET closes where on earth if for trending search
 - getTrends: GET treding topics on WOEID location
 - newTweet: POST create new tweet
 - deleteTweer: POST delete tweet by id
 - likeTweet: POST create a like for tweet
 - deleteLike: POST delete a like for tweet
 - showUser: GET user by user_id
 */
enum EndPoint: String {
    case url = "https://api.twitter.com/1.1/"
    case account = "account/verify_credentials.json"
    case query = "search/tweets.json"
    case newMessage = "direct_messages/events/new.json"
    case listDirectMessages = "direct_messages/events/list.json"
    case showDirectMessage = "direct_messages/events/show.json"
    case getClosestWOEID = "trends/closest.json"
    case getTrends = "trends/place.json"
    case newTweet = "statuses/update.json"
    case deleteTweet = "statuses/destroy/" //:id.json
    case likeTweet = "favorites/create.json"
    case deleteLike = "favorites/destroy.json"
    case showUser = "users/show.json"
}
