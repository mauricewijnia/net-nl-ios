//
//  AccountRegisterView.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class AccountRegisterView: UIView {
    
    var parentController: UIViewController? = nil
    
    @IBOutlet weak var lblRegister: UILabel!
    
    @IBOutlet var contentView: UIView!
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
        Bundle.main.loadNibNamed("AccountRegisterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.addBottomBorderWithColor(color: General.hexStringToUIColor(hex: "#D9D9D9"), width: 0.8)
        lblRegister.text = NSLocalizedString("register", comment: "")
    }
    
    @IBAction func onClick(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let controller: RegisterController = storyBoard.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        if let nc = parentController?.navigationController {
            nc.pushViewController(controller, animated: true)
        }
    }
}
