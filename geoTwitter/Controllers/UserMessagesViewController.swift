import UIKit
/// displays all messages from single user.
/// can also send message back to the user
class UserMessagesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputField: UITextField!
    
    private let alert = UIAlertController(title: "Success!", message: "Your message was sent!", preferredStyle: .alert)
    
    var messages: MyMessages?
    private let api = TwitterApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
   
    @IBAction func sendMsg(_ sender: UIButton) {
        if let id = messages?.account.id_str {
            if (inputField.text != "") {
                api.postDirectMessage(id: id, message: inputField.text ?? "")
                self.present(alert, animated: true)
            }
        }
    }
}

    // MARK: - tableview datasource etension
extension UserMessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = messages?.messages[indexPath.row].message_create.message_data.text
        return cell
    }
}
