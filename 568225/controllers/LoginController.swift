//
//  LoginController.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class LoginController: ApplicationController, LoginListener {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("login", comment: "")
        txtUsername.placeholder = NSLocalizedString("username", comment: "")
        txtPassword.placeholder = NSLocalizedString("password", comment: "")
        btnLogin.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        if let u = txtUsername.text, let p = txtPassword.text {
            User.login(listener: self, username: u, password: p)
        }
    }
    
    func onSuccess() {
        if let nc = self.navigationController {
            nc.popViewController(animated: true)
        }
        showAlert(title: NSLocalizedString("login_success", comment: ""))
    }
    
    func onFail() {
        showAlert(title: NSLocalizedString("login_failed", comment: ""))
    }
}
