import UIKit
import Kingfisher
/// Displays a single tweet
class SingleTweetController: UIViewController {
    
    var tweet: Tweet?

    @IBOutlet weak var testiLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var tweetFavoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testiLabel.text = tweet?.user.name
        tweetTextLabel.text = tweet?.text
        tweetTextLabel.sizeToFit()
        dateLabel.text = tweet?.created_at
        followersLabel.text = "\(tweet?.user.followers_count ?? 0)"
        friendsLabel.text = "\(tweet?.user.friends_count ?? 0)"
        tweetFavoriteLabel.text = "\(tweet?.favorite_count ?? 0)"
        retweetLabel.text = "\(tweet?.retweet_count ?? 0)"
        if let img = tweet?.user.profile_image_url_https {
                   userPicture.kf.setImage(with: URL(string: img))
               }
        }
    }
    

  
