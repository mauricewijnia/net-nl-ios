//
//  ArticleListCell.swift
//  568225
//
//  Created by Maurice Wijnia on 07/11/2018.
//  Copyright © 2018 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ArticleListCell: UICollectionViewCell {
    
    var article: Article? = nil

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func render() {
        imageView.kf.setImage(with: URL(string: (article?.image)!), placeholder: UIImage(named: "placeholder"))
        lblTitle.text = article?.title
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // SETUP!
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // CLEANUP!
        imageView.image = nil
        lblTitle.text = "";
    }
}
