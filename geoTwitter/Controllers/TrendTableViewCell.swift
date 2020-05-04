//
//  TrendTableViewCell.swift
//  geoTwitter
//
//  Created by iosdev on 30.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit

class TrendTableViewCell: UITableViewCell {
    @IBOutlet weak var trendName: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
