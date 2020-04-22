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
    var messages: MyMessages?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputText(_ sender: UITextField) {
    }
    @IBAction func sendMessage(_ sender: Any) {
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
