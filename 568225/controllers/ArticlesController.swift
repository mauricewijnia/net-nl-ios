//
//  ArticlesController.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class ArticlesController: ApplicationController, ArticlesDisplay {
    
    var articles: Array<Article> = []
    var nextId: Int? = nil
    
    @IBOutlet weak var articleTableView: ArticleTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("app_title", comment: "")
        articleTableView.setupPullToRefresh(controller: self)
        getArticles()
    }
    
    func handleRefresh() {
        getArticles()
    }
    
    func getArticles() {
        Article.all(callback: renderArticles)
    }
    
    func getMore() {
        Article.all(count: 20, nextId: nextId, callback: renderMore)
    }
    
    func renderArticles(articles: Article.Responses.Articles) {
        self.articles = articles.results
        self.nextId = articles.nextId
        if let nc = self.navigationController {
            articleTableView.render(articles: self.articles, navigationController: nc)
        }
    }
    
    func renderMore(articles: Article.Responses.Articles) {
        self.articles += articles.results
        self.nextId = articles.nextId
        articleTableView.renderMore(articles: self.articles)
    }
}
