//
//  UserMessagesViewController.swift
//  geoTwitter
//
//  Created by iosdev on 22.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit

class UserMessagesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var inputField: UITextField!
    
    let alert = UIAlertController(title: "Success!", message: "Your message was sent!", preferredStyle: .alert)
    
    
    var messages: MyMessages?
    let api = TwitterApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Do any additional setup after loading the view.
    }
   
    @IBAction func sendMsg(_ sender: UIButton) {
        if let id = messages?.account.id_str {
            if (inputField.text != "") {
                api.postDirectMessage(id: id, message: inputField.text ?? "")
                self.present(alert, animated: true)
            }
        }
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
