//
//  tabTableViewController.swift
//  geoTwitter
//
//  Created by iosdev on 15.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit

class tabTableViewController: UITableViewController {
    
    var tweets: [TweetQuery] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let api = APIFetch()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
                _ = api.subject
                    .subscribe {
                        if let element = $0.element {
                            self.tweets.append(element)
                        }
                }
                api.fetchAPI(query: "#helsinki")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].tweet.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tweets[indexPath.section].tweet[indexPath.row].user.name
        // Configure the cell...

        return cell
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
