//
//  TrendViewController.swift
//  geoTwitter
//
//  Created by iosdev on 30.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit

class TrendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let api = APIFetchT()
        let auth = Auth()
        private let userDefaults = UserDefaults.standard
        var trends: [TrendQuery] = [] {
            didSet {
                tableView.reloadData()
                
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            subsrcibeAndFetch()
            
            // Do any additional setup after loading the view.
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80.0
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return trends.count
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return trends[section].trends.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendCell", for: indexPath) as! TrendTableViewCell
            
            let trend = trends[indexPath.section].trends[indexPath.row]
            
            
            
            // cell.tweetCount.text = "\(trend.tweetVolume ??  0)"
            
            cell.trendName.text = trend.name
            cell.tweetCount.text = "\(trend.tweetVolume ??  0)"
            
            
            
            // print("\(trend.tweetVolume ??  0)")
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

    extension TrendViewController {
        
        func subsrcibeAndFetch() {
            _ = self.api.subject
                .subscribe { [weak self] in
                    if let element = $0.element {
                        self?.trends = [element]
                    }
            }
            self.api.fetchAPI()
        }
    }
