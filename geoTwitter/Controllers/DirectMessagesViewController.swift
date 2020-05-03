import UIKit
import RxSwift
import Kingfisher
/// displays users direct messages grouped by sender
class DirectMessagesViewController: UIViewController {
    
    private let api = TwitterApi()
    private let disposeBag = DisposeBag()
    private var messages:[Event] = []
    private var users:[Account] = []
    private var myMessages: [MyMessages] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        listMessages()
    }
    
    
    // MARK: - Navigation
    // opens new scene with all messages from single user
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = tableView.indexPathForSelectedRow else {return}
        if let destination = segue.destination as? UserMessagesViewController {
            destination.messages = myMessages[index.row]
        }
    }
}

    // MARK: - Tableview extension
extension DirectMessagesViewController: UITableViewDataSource {
    
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
    //MARK: - custom functions extension
extension DirectMessagesViewController {
    
    // lists all messages for users grouped by sender.
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
                                    if msg.message_create.sender_id == myMsg.account.id_str &&  !myMsg.messages.contains(msg) {
                                        myMsg.messages.append(msg)
                                    }
                                }
                            }
                        }, onCompleted: {
                            self.myMessages = self.myMessages.sorted(by: {$0.messages[0].id > $1.messages[0].id})
                            self.tableView.reloadData()
                        })
                        
                        .disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
    }
}
