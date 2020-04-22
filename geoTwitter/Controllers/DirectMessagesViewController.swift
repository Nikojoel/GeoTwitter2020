//
//  DirectMessagesViewController.swift
//  geoTwitter
//
//  Created by iosdev on 22.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DirectMessagesViewController: UIViewController {

    
    private let api = TwitterApi()
    private let disposeBag = DisposeBag()
    private var messages:[Event] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        api.listDirectMessages()
            .debug("directmessage")
            .subscribe(onNext: { [weak self] item in
            
                for item in item.events {
                    self?.messages.append(item)
                }
                print(self?.messages.count ?? 0)
        })
        .disposed(by: disposeBag)
        
        
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
