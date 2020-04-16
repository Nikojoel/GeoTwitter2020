//
//  SIngleTweetController.swift
//  geoTwitter
//
//  Created by iosdev on 16.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit

class SingleTweetController: UIViewController {
    
    var tweet: Tweet?

    let profPic = UIImage(named: "profPic1")
    
    
    @IBOutlet weak var testiLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
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
        profilePicture.image = profPic
        dateLabel.text = tweet?.created_at
        followersLabel.text = "\(tweet?.user.followers_count ?? 0)"
        friendsLabel.text = "\(tweet?.user.friends_count ?? 0)"
        tweetFavoriteLabel.text = "\(tweet?.favorite_count ?? 0)"
        retweetLabel.text = "\(tweet?.retweet_count ?? 0)"
       /* date formatting, not working yet
        let input = tweet?.created_at
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        if let date = formatter.date(from: input) {
            print(date)
            
            let displayFormatter = DateFormatter()
                displayFormatter.dateFormat = "MMM d, h:mm a"
        dateLabel.text = displayFormatter.string(from: date)
        }
         */
    }
            
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

