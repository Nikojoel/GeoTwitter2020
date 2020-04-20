//
//  tweetLocation.swift
//  geoTwitter
//
//  Created by Niko Holopainen on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation


struct TweetLocation: Codable {
    let results: [results]
}

struct results: Codable {
    var geometry: [String: Double]
}




