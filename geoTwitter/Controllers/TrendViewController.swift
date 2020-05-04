//
//  TrendViewController.swift
//  geoTwitter
//
//  Created by iosdev on 30.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation

class TrendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let twitterApi = TwitterApi()
    private let disposeBag = DisposeBag()
    private var disposable: Disposable?
    private let locationManager = CLLocationManager()
    
    var trends: [TrendQuery] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
    }
    override func viewDidAppear(_ animated: Bool) {
        if let coords = locationManager.location?.coordinate {
            disposable = twitterApi.getClosesWoeId(lat: coords.latitude, long: coords.longitude)
                .subscribe(onNext: {
                    print($0[0].woeid)
                    _ = self.twitterApi.getTrends(id: "\($0[0].woeid)")
                        .subscribe(onNext: {
                            self.trends = $0
                        })
                })
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disposable?.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trends.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trends[section].trends.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendCell", for: indexPath) as! TrendTableViewCell
        
        let trend = trends[indexPath.section].trends[indexPath.row]
        cell.trendName.text = trend.name
        cell.tweetCount.text = "\(trend.tweetVolume ??  0)"
        return cell
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let trendIndex = tableView.indexPathForSelectedRow else { return }
        if let destination = segue.destination as? TweetTableViewController {
            destination.trend = trends[trendIndex.section].trends[trendIndex.row].name
        }
    }
}


