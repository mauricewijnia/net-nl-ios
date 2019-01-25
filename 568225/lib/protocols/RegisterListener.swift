//
//  RegisterListener.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation

protocol RegisterListener {
    func onSuccess(success: Bool, message: String)
    func onFail()
}
