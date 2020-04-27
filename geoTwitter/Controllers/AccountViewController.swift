//
//  AccountViewController.swift
//  geoTwitter
//
//  Created by iosdev on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import CoreData

class AccountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    //@IBOutlet weak var location: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    private let api = TwitterApi()
    private let disposeBag = DisposeBag()
    private var account: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
}
        /*api.myAccount().subscribe(onNext: { [weak self] item in
                print("next")
            self?.account = item
            var img = item.profile_image_url_https
            let range = img.index(img.endIndex, offsetBy: -11)..<img.endIndex
            img.removeSubrange(range)
            img.insert(contentsOf: ".jpg", at: img.endIndex)
            self?.profileImage.kf.setImage(with: URL(string: img))
            self?.fullName.text = item.name
            self?.screenName.text = "@" + item.screen_name
            self?.followersCount.text = "\(item.followers_count)"
            self?.friendsCount.text = "\(item.friends_count)"
           // self?.location.text = item.profile_location
            self?.desc.text = item.description
            }).disposed(by: disposeBag)
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

 }*/
