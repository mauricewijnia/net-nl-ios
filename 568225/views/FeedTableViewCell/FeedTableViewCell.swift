//
//  FeedTableViewCell.swift
//  568225
//
//  Created by Maurice Wijnia on 09/11/2018.
//  Copyright © 2018 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    var feed: Feed?
    
    @IBOutlet weak var lblName: UILabel!
    
    func render() {
        lblName.text = feed?.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // SETUP!
        lblName.text = feed?.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // CLEANUP!
        lblName.text = nil
    }
}
