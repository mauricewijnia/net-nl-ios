//
//  Article.swift
//  568225
//
//  Created by Maurice Wijnia on 19/10/2018.
//  Copyright © 2018 Maurice Wijnia. All rights reserved.
//

import Foundation
import Alamofire

class Article: Model, Codable {
    var id: Int
    var title: String
    var summary: String
    var url: String
    var publishDate: String
    var image: String
    var isLiked: Bool
    var feed: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case summary = "Summary"
        case url = "Url"
        case publishDate = "PublishDate"
        case image = "Image"
        case isLiked = "IsLiked"
        case feed = "Feed"
    }
    
    init(id: Int, title: String, summary: String, url: String, publishDate: String, image: String, isLiked: Bool, feed: Int) {
        self.id = id
        self.title = title
        self.summary = summary
        self.url = url
        self.publishDate = publishDate
        self.image = image
        self.isLiked = isLiked
        self.feed = feed
    }
    
    static func all(count: Int = 20, nextId: Int? = nil, callback: @escaping (Responses.Articles)->()) {
        var url = apiBaseUrl + "api/Articles"
        
        if let id = nextId {
            url = url + "/\(id)"
        }
        
        url = url + "?count=\(count)"
        
        var headers: HTTPHeaders = [:]
        
        if let u = User.currentUser() {
            headers["x-authtoken"] = u.authToken
        }
        
        Alamofire.request(url, method: .get,parameters: [:], headers: headers).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                do {
                    let articles = try JSONDecoder().decode(Responses.Articles.self, from: response.data!)
                    callback(articles)
                } catch {
                    print("Error decoding:\(String(describing: response.result.error))")
                }
                break
            case .failure(_):
                print("Error message:\(String(describing: response.result.error))")
                break
            }
        }
    }
    
    static func favorites(callback: @escaping (Responses.Articles)->()) {
        let url = "\(apiBaseUrl)api/Articles/liked"
        
        var headers: HTTPHeaders = [:]
        
        if let u = User.currentUser() {
            headers["x-authtoken"] = u.authToken
        }
        Alamofire.request(url, method: .get, parameters: [:], headers: headers).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                do {
                    let articles = try JSONDecoder().decode(Responses.Articles.self, from: response.data!)
                    callback(articles)
                } catch {
                    print("Error decoding:\(String(describing: response.result.error!))")
                }
                break
            case .failure(_):
                print("Error message:\(String(describing: response.result.error!))")
                break
            }
        }
    }
    
    static func like(listener: LikeListener, article: Article) {
        let url = "\(apiBaseUrl)api/Articles/\(article.id)/like"
        
        var headers: HTTPHeaders = [:]
        
        if let u = User.currentUser() {
            headers["x-authtoken"] = u.authToken
        }
        
        Alamofire.request(url, method: .put, parameters: [:], headers: headers).responseString { (response) in
            switch(response.result) {
            case .success(_):
                listener.onLikeSuccess()
                break
            case .failure(_):
                print("Error message:\(String(describing: response.result.error!))")
                listener.onLikeFail()
                break
            }
        }
    }
    
    static func unlike(listener: LikeListener, article: Article) {
        let url = "\(apiBaseUrl)api/Articles/\(article.id)/like"
        
        var headers: HTTPHeaders = [:]
        
        if let u = User.currentUser() {
            headers["x-authtoken"] = u.authToken
        }
        
        Alamofire.request(url, method: .delete, parameters: [:], headers: headers).responseString { (response) in
            switch(response.result) {
            case .success(_):
                listener.onLikeSuccess()
                break
            case .failure(_):
                print("Error message:\(String(describing: response.result.error!))")
                listener.onLikeFail()
                break
            }
        }
    }
    
    class Responses {
        struct Articles: Codable {
            let results: Array<Article>
            let nextId: Int
            
            enum CodingKeys: String, CodingKey {
                case results = "Results"
                case nextId = "NextId"
            }
        }
    }
}
