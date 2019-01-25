//
//  AccountController.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class AccountController: ApplicationController {
    @IBOutlet weak var logoutView: AccountLogoutView!
    @IBOutlet weak var loginView: AccountLoginView!
    @IBOutlet weak var registerView: AccountRegisterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("account", comment: "")
        loginView.setParentController(parentController: self)
        registerView.setParentController(parentController: self)
        logoutView.setAccountController(accountController: self)
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refresh() {
        if User.currentUser() != nil {
            loginView.isHidden = true
            registerView.isHidden = true
            logoutView.isHidden = false
        } else {
            loginView.isHidden = false
            registerView.isHidden = false
            logoutView.isHidden = true
        }
    }
}
