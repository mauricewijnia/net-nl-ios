//
//  ArticleDisplay.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation

protocol ArticlesDisplay{
    var articles: Array<Article> { get set }
    
    func handleRefresh()
    func getArticles()
    func getMore()
    func renderArticles(articles: Article.Responses.Articles)
    func renderMore(articles: Article.Responses.Articles)
}
