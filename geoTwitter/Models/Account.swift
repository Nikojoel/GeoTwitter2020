// user account from twitter json
import Foundation

struct Account: Decodable{
    let id: Int
    let id_str: String
    let name: String
    let screen_name: String
    let profile_location: String?
    let description: String?
    let url: String?
    let followers_count: Int
    let friends_count: Int
    let profile_image_url_https: String
    
    

}
