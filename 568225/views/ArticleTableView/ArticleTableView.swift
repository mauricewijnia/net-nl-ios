//
//  ArticleTableView.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class ArticleTableView: UIView {
    
    var articles: Array<Article> = []
    var navigationController: UINavigationController?
    var parentController: ArticlesDisplay?
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func commonSetup() {
        Bundle.main.loadNibNamed("ArticleTableView", owner: self, options: nil)
        contentView.fixInView(self)
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
    }
    
    func setupPullToRefresh(controller: ArticlesDisplay) {
        parentController = controller
        refreshControl.addTarget(self, action:
            #selector(refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        parentController?.handleRefresh()
    }
    
    func render(articles: Array<Article>, navigationController: UINavigationController) {
        self.articles = articles
        self.navigationController = navigationController
        
        tableView.reloadData()
        endRefresh()
        stopLoading()
    }
    
    func renderMore(articles: Array<Article>) {
        if self.articles.count < articles.count {
            self.articles = articles
            tableView.reloadData()
        }
        endRefresh()
        stopLoading()
    }
    
    func endRefresh() {
        if parentController != nil {
            refreshControl.endRefreshing()
        }
    }
    
    func startLoading() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopLoading() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}

extension ArticleTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell",
                                                     for: indexPath) as! ArticleTableViewCell
            cell.render(article: articles[indexPath.item])
            
            if indexPath.row == articles.count - 1 {
                if let controller = parentController {
                    controller.getMore()
                }
            }
            
            return cell
    }
}

extension ArticleTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let articleController: ArticleViewController = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        articleController.article = articles[indexPath.item]
        navigationController?.pushViewController(articleController, animated: true)
    }
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

