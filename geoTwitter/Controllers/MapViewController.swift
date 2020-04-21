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
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let api = ReverseGeoApi()
    private let disposeBag = DisposeBag()
    private let twitterApi = TwitterApi()
    var locations: [Tweet] = [] {
        didSet {
            for loc in locations {
                reverseGeoCode(loc)
            }
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsScale = true
        searchBar.delegate = self
    }
    
    func searchForTweets(_ keyWord: String) {
        var temp = [Tweet]()
        twitterApi.searchTweet(keyWord).subscribe(onNext: { item in
            for tweet in item.tweet {
                if tweet.user.location != "" {
                    temp.append(tweet)
                    print("\(tweet.user.location)")
                }
            }
            self.locations = temp
        }).disposed(by: disposeBag)
    }
    
    func reverseGeoCode(_ tweet: Tweet) {
        api.useReverseGeoCode(tweet.user.location).subscribe(onNext: {item in
            // Insert more data to the annotation
            let annotation = MKPointAnnotation()
            if item.results.count != 0 {
                annotation.title = tweet.user.name
                annotation.subtitle = tweet.user.description
                annotation.coordinate = CLLocationCoordinate2D(latitude: item.results[0].geometry["lat"] ?? 0, longitude:
                    item.results[0].geometry["lng"] ?? 0)
                self.mapView.addAnnotation(annotation)
            }
        }).disposed(by: disposeBag)
    }
}

extension MapViewController: UISearchBarDelegate {
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           self.searchForTweets(searchBar.text ?? "")
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           //self.searchBar.endEditing(true)
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           //self.searchBar.endEditing(true)
       }
   }

