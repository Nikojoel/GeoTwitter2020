//
//  reverseGeoApi.swift
//  geoTwitter
//
//  Created by Niko Holopainen on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation
import RxSwift
/**
Class for reverse geocode api
- useReverseGeoCode: encodes url and returns observable type of TweetLocation
*/
class ReverseGeoApi {
    
    private let networkService = NetworkServiceNoAuth()
    
    /**
       Creates an api standard query to pass url to the networkservice handler
        - Returns: an Observable typed TweetLocation
        */
    func useReverseGeoCode(_ cityName: String) -> Observable<TweetLocation> {
        let encodeCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "https://api.opencagedata.com/geocode/v1/json?q=\(encodeCity ?? "")&key=\(Keys.reverseGeoApi.rawValue)"
        return networkService.apiFetchGET(url: url)
    }
}
