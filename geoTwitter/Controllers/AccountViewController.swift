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

class AccountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    private let api = TwitterApi()
    private let disposeBag = DisposeBag()
    private var account: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.myAccount().subscribe(onNext: { [weak self] item in
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
         self?.desc.text = item.description
         }).disposed(by: disposeBag)
    }
    @IBAction func logOutButton(_ sender: Any) {
        let userData = UserDefaults.standard
        userData.removeObject(forKey: "userToken")
        userData.removeObject(forKey: "userSecret")
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
      
