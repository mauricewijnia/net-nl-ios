//
//  User.swift
//  568225
//
//  Created by Maurice Wijnia on 25/01/2019.
//  Copyright © 2019 Maurice Wijnia. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class User: Model {
    var username: String;
    var authToken: String;
    
    init(username: String, authToken: String) {
        self.username = username
        self.authToken = authToken
    }
    
    func login() {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(authToken, forKey: "authToken")
    }
    
    func logoff() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
    
    static func currentUser() -> User? {
        if let u = UserDefaults.standard.string(forKey: "username"), let a = UserDefaults.standard.string(forKey: "authToken"){
            return User(username: u, authToken: a)
        }
        
        return nil
    }
    
    static func login(listener: LoginListener, username: String, password: String) {
        let url = "\(apiBaseUrl)api/Users/login"
        
        let params: Parameters = [
            "UserName": username,
            "Password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                do {
                    let authToken = try JSONDecoder().decode(Responses.Login.self, from: response.data!)
                    User(username: username, authToken: authToken.authToken).login()
                    listener.onSuccess()
                } catch {
                    listener.onFail()
                    print("Error decoding:\(String(describing: response.result.error))")
                }
                break
            case .failure(_):
                listener.onFail()
                print("Error message:\(String(describing: response.result.error))")
                break
            }
        }
    }
    
    static func register(listener: RegisterListener, username: String, password: String) {
        let url = "\(apiBaseUrl)api/Users/register"
        
        let params: Parameters = [
            "UserName": username,
            "Password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                do {
                    let register = try JSONDecoder().decode(Responses.Register.self, from: response.data!)
                    listener.onSuccess(success: register.success, message: register.message)
                } catch {
                    listener.onFail()
                    print("Error decoding:\(String(describing: response.result.error))")
                }
                break
            case .failure(_):
                listener.onFail()
                print("Error message:\(String(describing: response.result.error))")
                break
            }
        }
    }
    
    class Responses {
        struct Login: Codable {
            let authToken: String
            
            enum CodingKeys: String, CodingKey {
                case authToken = "AuthToken"
            }
        }
        
        struct Register: Codable {
            let success: Bool
            let message: String
            
            enum CodingKeys: String, CodingKey {
                case success = "Success"
                case message = "Message"
            }
        }
    }
}
