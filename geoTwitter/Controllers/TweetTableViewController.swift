//
//  tabTableViewController.swift
//  geoTwitter
//
//  Created by iosdev on 15.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import RxSwift

class TweetTableViewController: UITableViewController {
    
    
    @IBOutlet weak var logInButton: UIBarButtonItem!
    
    let api = APIFetch()
    let auth = Auth()
    private let userDefaults = UserDefaults.standard
    var tweets: [TweetQuery] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        
        if (userDefaults.string(forKey: "userToken") != nil && userDefaults.string(forKey: "userSecret") != nil) {
            tableView.isHidden = false
            subsrcibeAndFetch()
        }
        
    }
    
    @IBAction func tapLogInButton(_ sender: UIBarButtonItem) {
        auth.authUserToken()
        _ = auth.status
            .subscribe {
                if $0.element ?? false {
                    self.logInButton.isEnabled = false
                    self.tableView.isHidden = false
                    self.subsrcibeAndFetch()
                }
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tweetIndex = tableView.indexPathForSelectedRow else { return }
        if let destination = segue.destination as? SingleTweetController {
            
            destination.tweet = tweets[tweetIndex.section].tweet[tweetIndex.row]
            
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        let tweet = tweets[indexPath.section].tweet[indexPath.row]
        cell.userName.text = tweet.user.screen_name
        cell.tweetText.text = tweet.text
        return cell
    }
}

extension TweetTableViewController {
    
    func subsrcibeAndFetch() {
        _ = self.api.subject
            .subscribe { [weak self] in
                if let element = $0.element {
                    self?.tweets = [element]
                }
        }
        self.api.fetchAPI(query: "#helsinki")
    }
}
