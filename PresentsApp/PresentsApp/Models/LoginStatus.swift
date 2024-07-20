import Foundation
import SwiftUI

class LoginStatus: ObservableObject {
    
    @Published var loggedUserId: String? {
        didSet {
            if let uuid = loggedUserId {
                UserDefaults.standard.set(uuid, forKey: "loggedUserId")
            } else {
                UserDefaults.standard.removeObject(forKey: "loggedUserId")
            }
        }
    }
    
    @Published var accessToken: String? {
        didSet {
            if let accessToken = accessToken {
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
            } else {
                UserDefaults.standard.removeObject(forKey: "accessToken")
            }
        }
    }
    
    @Published var refreshToken: String? {
        didSet {
            if let refreshToken = refreshToken {
                UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
            } else {
                UserDefaults.standard.removeObject(forKey: "refreshToken")
            }
        }
    }
    
    init() {
        if let uuidString = UserDefaults.standard.string(forKey: "loggedUserId") {
            self.loggedUserId = uuidString
        } else {
            self.loggedUserId = nil
        }
        
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            self.accessToken = accessToken
        } else {
            self.accessToken = nil
        }
        
        if let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") {
            self.refreshToken = refreshToken
        } else {
            self.refreshToken = nil
        }
    }
}
