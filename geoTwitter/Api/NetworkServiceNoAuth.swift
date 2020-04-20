//
//  NetworkServiceNoAuth.swift
//  geoTwitter
//
//  Created by Niko Holopainen on 20.4.2020.
//  Copyright © 2020 enarm. All rights reserved.
//

import Foundation
import OAuthSwift
import RxSwift


class NetworkServiceNoAuth {
    
    func apiFetchGET<T:Decodable>(url: String) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            
            // let formatUrl = URL(string: url)
            guard let formatUrl = URL(string: url) else {
                fatalError("url error")
            }
           
            let task = URLSession.shared.dataTask(with: formatUrl) { data, response, error in
                if let error = error {
                    print("error in urlsession \(error)")
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        print("error in httpresponse")
                        return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let coords = try decoder.decode(T.self, from: data)
                        observer.onNext(coords)
                        observer.onCompleted()
                        
                    } catch let err {
                        print(err)
                    }
                }
            }
            task.resume()
            
            return Disposables.create {
                print("disposable created")
            }
        }
    }
}
