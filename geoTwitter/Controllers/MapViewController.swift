//
//  MapViewController.swift
//  geoTwitter
//
//  Created by Niko Holopainen on 19.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var resultLabel: UILabel!
    private let api = ReverseGeoApi()
    private let disposeBag = DisposeBag()
    private let twitterApi = TwitterApi()
    private var tweetsNoLocation = [TweetQuery]()
    var locations: [Tweet] = [] {
        didSet {
            for loc in locations {
                reverseGeoCode(loc.user.location)
            }
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        var temp = [Tweet]()
        twitterApi.searchTweet("helsinki").subscribe(onNext: { item in
            for tweet in item.tweet {
                if tweet.user.location != "" {
                    temp.append(tweet)
                    print("\(tweet.user.location)")
                }
            }
            self.locations = temp
            print("before dispose \(self.locations.count)")
        }).disposed(by: disposeBag)
    }
    
    func reverseGeoCode(_ cityName: String) {
        api.useReverseGeoCode(cityName).subscribe(onNext: {item in
            print("\(item.results[0])")
            // Insert more data to the annotation
            let annotation = MKPointAnnotation()
            annotation.title = "moi"
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.results[0].geometry["lat"] ?? 0, longitude:
                item.results[0].geometry["lng"] ?? 0)
            self.mapView.addAnnotation(annotation)
        }).disposed(by: disposeBag)
    }
}

