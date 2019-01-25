//
//  AccountLogoutView.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class AccountLogoutView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblLogout: UILabel!
    
    var accountController: AccountController? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func setAccountController(accountController: AccountController) {
        self.accountController = accountController
    }
    
    func commonSetup() {
        Bundle.main.loadNibNamed("AccountLogoutView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addBottomBorderWithColor(color: General.hexStringToUIColor(hex: "#D9D9D9"), width: 0.8)
        lblLogout.text = NSLocalizedString("logout", comment: "")
    }
    
    @IBAction func onClick(_ sender: Any) {
        User.currentUser()?.logoff()
        if let ac = accountController {
            ac.refresh()
        }
    }
}
