//
//  tabTableViewController.swift
//  geoTwitter
//
//  Created by iosdev on 15.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class TweetTableViewController: UITableViewController {
    
    
    @IBOutlet weak var logInButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let api = APIFetch()
    let auth = Auth()
    private let userDefaults = UserDefaults.standard
    var tweets: [TweetQuery] = [] {
        didSet {
            tableView.reloadData()
            loadingIndicator.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        loadingIndicator.isHidden = true
        searchBar.delegate = self
        searchBar.isHidden = true
        self.tableView.keyboardDismissMode = .onDrag
        if (userDefaults.string(forKey: "userToken") != nil && userDefaults.string(forKey: "userSecret") != nil) {
            logInButton.isEnabled = false
            searchBar.isHidden = false
            
            subsrcibeAndFetch()
        }
        
    }
    // MARK: - Actions
    @IBAction func tapLogInButton(_ sender: UIBarButtonItem) {
       
        auth.authUserToken()
            .subscribe(
                onNext: { element in
                print("next")
                if element {
                    self.logInButton.isEnabled = false
                    self.tableView.isHidden = false
                    self.searchBar.isHidden = false
                    self.subsrcibeAndFetch()
                }
            }).dispose()
            
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
        if let img = tweet.user.profile_image_url_https {
           cell.profileImage.kf.setImage(with: URL(string: img))
        }
        
        cell.userName.text = tweet.user.screen_name
        cell.tweetText.text = tweet.text
        return cell
    }
}

    //MARK: - custom functions
extension TweetTableViewController {
    
    func subsrcibeAndFetch() {
        _ = self.api.subject
            .subscribe { [weak self] in
                if let element = $0.element {
                    self?.tweets = [element]
                }
        }
        //self.api.fetchAPI(query: "#helsinki")
    }
}

    //MARK: - Searchbar delegate
extension TweetTableViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        loadingIndicator.isHidden = false
        self.api.fetchAPI(query: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    

}


