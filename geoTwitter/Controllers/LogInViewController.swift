//
//  LogInViewController.swift
//  geoTwitter
//
//  Created by iosdev on 29.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import RxSwift

class LogInViewController: UIViewController {
    
    
    private let userData = UserDefaults.standard
    private let auth = Auth()
    private var disposable: Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (userData.string(forKey: "userToken") != nil && userData.string(forKey: "userSecret") != nil) {
            self.performSegue(withIdentifier: "showMain", sender: self)
        }
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        disposable = auth.authUserToken()
            .subscribe(onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
                self.navigateToMain()
            }
        )
    }
    
    func navigateToMain() {
        disposable?.dispose()
        self.performSegue(withIdentifier: "showMain", sender: self)
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
