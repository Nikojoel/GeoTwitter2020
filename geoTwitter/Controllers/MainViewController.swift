//
//  ViewController.swift
//  geoTwitter
//
//  Created by iosdev on 7.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//
import Foundation
import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    private let userDefaults = UserDefaults.standard
    var auth = Auth()
    @IBOutlet weak var logInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // rxswift subscription example
        //        api.subject
        //            .subscribe {
        //                if let element = $0.element {
        //                    self.tweets.append(element)
        //                }
        //        }
        //        api.fetchAPI(query: "#helsinki")
        //    }
        
        //auth.authUserToken()
        
        
        //var auth = Auth()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkTokenAndPresent()
    }
    
    @IBAction func pressLogInButton(_ sender: UIButton) {
        auth.authUserToken()
        _ = auth.status
            .subscribe {
                if $0.element ?? false {
                    self.logInButton.isHidden = true
                    self.checkTokenAndPresent()
                }
        }
    }
}


// Custom functions extension
extension MainViewController {
    
    func checkTokenAndPresent() {
        if (userDefaults.string(forKey: "userToken") != nil && userDefaults.string(forKey: "userSecret") != nil) {
            let vc = tabTableViewController()
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .fullScreen
            present(navi, animated: true)
        }
    }
}
