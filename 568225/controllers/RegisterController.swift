//
//  RegisterController.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class RegisterController: ApplicationController, RegisterListener {

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("register", comment: "")
        txtUsername.placeholder = NSLocalizedString("username", comment: "")
        txtPassword.placeholder = NSLocalizedString("password", comment: "")
        btnRegister.setTitle(NSLocalizedString("register", comment: ""), for: .normal)
    }
    
    func onSuccess(success: Bool, message: String) {
        if success {
            if let nc = self.navigationController {
                nc.popViewController(animated: true)
            }
            showAlert(title: NSLocalizedString("registration_success", comment: ""))
        } else {
            showAlert(title: NSLocalizedString("registration_failed", comment: ""), message: message)
        }

    }
    
    func onFail() {
        showAlert(title: NSLocalizedString("registration_failed", comment: ""))
    }
    
    @IBAction func onRegisterClick(_ sender: Any) {
        if let u = txtUsername.text, let p = txtPassword.text {
            User.register(listener: self, username: u, password: p)
        }
    }
}
