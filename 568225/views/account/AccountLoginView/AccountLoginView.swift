//
//  AccountLoginView.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class AccountLoginView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblLogin: UILabel!
    var parentController: UIViewController? = nil
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func setParentController(parentController: UIViewController) {
        self.parentController = parentController
    }
    
    func commonSetup() {
        Bundle.main.loadNibNamed("AccountLoginView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addBottomBorderWithColor(color: General.hexStringToUIColor(hex: "#D9D9D9"), width: 0.8)
        lblLogin.text = NSLocalizedString("login", comment: "")
    }
    
    @IBAction func onClick(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let controller: LoginController = storyBoard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        if let nc = parentController?.navigationController {
            nc.pushViewController(controller, animated: true)
        }
    }
}
