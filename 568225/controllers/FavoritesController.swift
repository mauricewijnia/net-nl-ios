//
//  FavoritesController.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class FavoritesController: ApplicationController, ArticlesDisplay {
    var articles: Array<Article> = []
    
    @IBOutlet weak var articleTableView: ArticleTableView!
    
    override func viewWillAppear(_ animated: Bool) {
        getArticles()
    }
    
    func handleRefresh() {
        getArticles()
    }
    
    func getArticles() {
        Article.favorites(callback: renderArticles)
    }
    
    func getMore() {
        // API does not support incremental loading
    }
    
    func renderArticles(articles: Article.Responses.Articles) {
        self.articles = articles.results
        if let nc = self.navigationController {
            articleTableView.render(articles: self.articles, navigationController: nc)
        }
    }
    
    func renderMore(articles: Article.Responses.Articles) {
        // API does not support incremental loading
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("favorites", comment: "")
        articleTableView.setupPullToRefresh(controller: self)
        getArticles()
    }
}
