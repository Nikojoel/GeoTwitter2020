//
//  TweetTableViewCell.swift
//  geoTwitter
//
//  Created by iosdev on 16.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
