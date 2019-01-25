//
//  ArticleTableViewCell.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    var article: Article? = nil
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var favoriteView: UIImageView!
    
    func render(article: Article) {
        self.article = article
        refresh()
    }
    
    func refresh() {
        if let a = article {
            imgView.kf.setImage(with: URL(string: a.image))
            lblTitle.text = a.title
            
            if a.isLiked {
                favoriteView.isHidden = false
            } else {
                favoriteView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // SETUP!
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // CLEANUP!
        imgView.image = UIImage(named: "placeholder")
        lblTitle.text = ""
        favoriteView.isHidden = true
    }
}
