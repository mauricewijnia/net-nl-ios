//
//  ApplicationController.swift
//  568225
//
//  Created by Maurice Wijnia on 19/10/2018.
//  Copyright © 2018 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit

class ApplicationController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showAlert(title: String = "",message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
