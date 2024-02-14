//
//  AuthManager.swift
//  MyFacetime
//
//  Created by Afraz Siddiqui on 2/14/24.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()

    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }

    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                CallManager.shared.setUp(email: email)
            }
            completion(error == nil)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if error == nil {
                CallManager.shared.setUp(email: email)
            }
            completion(error == nil)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
