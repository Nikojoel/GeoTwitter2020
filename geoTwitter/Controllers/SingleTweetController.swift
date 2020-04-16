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

    @IBOutlet weak var testiLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        testiLabel.text = tweet?.user.name
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

}
