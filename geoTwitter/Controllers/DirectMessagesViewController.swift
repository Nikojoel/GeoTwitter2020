//
//  DirectMessagesViewController.swift
//  geoTwitter
//
//  Created by iosdev on 22.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class DirectMessagesViewController: UIViewController {

    
    private let api = TwitterApi()
    private let disposeBag = DisposeBag()
    private var messages:[Event] = []
    private var users:[Account] = []
    private var myMessages: [MyMessages] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    
        listMessages()
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

extension DirectMessagesViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! DirectMessageTableViewCell
        let message = myMessages[indexPath.row]
        cell.profPic.kf.setImage(with: URL(string: message.account.profile_image_url_https))
        cell.screenName.text = message.account.screen_name
        cell.lastMessage.text = "\(message.messages[message.messages.count - 1].message_create.message_data.text)"
        return cell
    }
}

extension DirectMessagesViewController {
    func listMessages() {
        api.listDirectMessages()
            .subscribe(onNext: {item in
                for item in item.events {
                    self.messages.append(item)
                    self.api.showUser(id: item.message_create.sender_id)
                        .subscribe(onNext: { account in
                            let count = self.myMessages.filter { i in
                                i.account.id == account.id
                            }
                            if count.count == 0 {
                                self.myMessages.append(MyMessages(account: account))
                            }
                            for myMsg in self.myMessages {
                                for msg in self.messages {
                                    if msg.message_create.sender_id == myMsg.account.id_str {
                                        myMsg.messages.append(msg)
                                    }
                                }
                            }
                            for x in self.myMessages {
                                print(x.account.name)
                                for i in x.messages {
                                    print(i.message_create.message_data)
                                }
                            }
                        }, onCompleted: {
                            self.tableView.reloadData()
                        })
                        
                        .disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }
}
