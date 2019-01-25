//
//  ArticleViewController.swift
//  568225
//
//  Created by Maurice Wijnia on 09/11/2018.
//  Copyright © 2018 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewController: ApplicationController, LikeListener {
    
    var article: Article?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblLink: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("article", comment: "")
        if let art = article {
            lblTitle.text = art.title
            lblSummary.text = art.summary
            lblLink.text = art.url
            lblLink.isUserInteractionEnabled = true
            imageView.kf.setImage(with: URL(string: art.image), placeholder: UIImage(named: "placeholder"))
            btnReadMore.setTitle(NSLocalizedString("read_more", comment: ""), for: .normal)
        }

        setupLike()
    }
    
    func setupLike() {
        if let art = article {
            if art.isLiked {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("unlike", comment: ""), style: .plain, target: self, action: #selector(onUnlike))
            } else {

                navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("like", comment: ""), style: .plain, target: self, action: #selector(onLike))
            }

        }
    }
    
    @objc func onLike() {
        if let a = article {
            Article.like(listener: self, article: a)
        }
    }
    
    @objc func onUnlike() {
        if let a = article {
            Article.unlike(listener: self, article: a)
        }
    }
    
    func onLikeSuccess() {
        if let a = article {
            article!.isLiked = !a.isLiked
            setupLike()
        }
    }
    
    func onLikeFail() {
        showAlert(title: NSLocalizedString("something_went_wrong", comment: ""))
    }
    
    @IBAction func onReadMore(_ sender: Any) {
        if let art = article {
            UIApplication.shared.open(NSURL(string:art.url)! as URL)
        }
    }
    @IBAction func onLinkClick(_ sender: Any) {
        if let art = article {
            UIApplication.shared.open(NSURL(string:art.url)! as URL)
        }
    }
}
