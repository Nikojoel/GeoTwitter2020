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

/**
Mapview controlller for displaying MKMapView and all business logic behind it.
 Extended with UiSearchBarDelegate
 - viewDidLoad
 - searchForTweets
 - reverseGeoCode
*/

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
        mapView.showsUserLocation = true
        searchBar.delegate = self
    }
    
    /**
    Initiates observers that handle incoming Tweet data
     - Parameters: keyWord: String - Actual keyword the user inputs
     */
    func searchForTweets(_ keyWord: String) {
        var temp = [Tweet]()
        var tweetData = [[Tweet]]()
        
        twitterApi.searchTweet(keyWord).subscribe(onNext: { item in
            let nextResults = item.metaData.next_results ?? ""
            tweetData.append(item.tweet)

            self.twitterApi.searchNextTweet(nextResults).subscribe(onNext: {nextItem in
                tweetData.append(nextItem.tweet)
                for tweetArray in tweetData     {
                    for tweet in tweetArray {
                        if tweet.user.location != "" {
                            temp.append(tweet)
                        }
                    }
                }
                print(nextItem.metaData.next_results ?? "")
                self.locations = temp
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    /**
      Reverse geocodes the tweet given in the parameter
     - Parameters: tweet: Tweet - Reverse geocodable tweet
     */
    func reverseGeoCode(_ tweet: Tweet) {
        api.useReverseGeoCode(tweet.user.location).subscribe(onNext: {item in
            // Insert more data to the annotation
            let annotation = MKPointAnnotation()
            if item.results.count != 0 {
                annotation.title = tweet.user.name
                annotation.subtitle = tweet.user.description
                annotation.coordinate = CLLocationCoordinate2D(latitude: item.results[0].geometry["lat"] ?? 0, longitude:
                    item.results[0].geometry["lng"] ?? 0)
                let main = DispatchQueue.main
                main.async {
                    self.mapView.addAnnotation(annotation)
                    self.mapView.deselectAnnotation(annotation, animated: false)
               }
            }
        }).disposed(by: disposeBag)
    }
}

extension MapViewController: UISearchBarDelegate {
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           self.searchForTweets(searchBar.text ?? "")
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           self.searchBar.endEditing(true)
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           self.searchBar.endEditing(true)
       }
   }
