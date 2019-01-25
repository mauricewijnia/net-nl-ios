//
//  Feed.swift
//  568225
//
//  Created by Maurice Wijnia on 09/11/2018.
//  Copyright © 2018 Maurice Wijnia. All rights reserved.
//

import Foundation
import Alamofire

class Feed: Model, Codable {
    var id: Int;
    var name: String;
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
    
    static func all(callback: @escaping (Array<Feed>)->()) {
        let url = apiBaseUrl + "api/Feeds"
        Alamofire.request(url).responseData { (response) in
            let feeds = try? JSONDecoder().decode(Array<Feed>.self, from: response.data!)
            print(feeds)
            callback(feeds!)
        }
    }
}
