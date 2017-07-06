//
//  AuthService.swift
//  Micro-Investment
//
//  Created by Jacob Marcil on 2017-07-04.
//  Copyright © 2017 ETS. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import FirebaseAuth
import FirebaseStorage

struct AuthService{

    var dataBaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        return Storage.storage().reference()
    }


    // Creating the SignUp function
    func SignUp(email: String, prenom: String, nom: String, datedenaissance: String, password: String){
    
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if(error == nil){
               // self.setUserInfo(user: user, email: email, prenom: prenom, nom: nom, datedenaissance: datedenaissance, password: password)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    // Create the Set User Info function
    private func setUserInfo(user: User!, email: String, prenom: String, nom: String, datedenaissance: String, password: String){
        
        let userInfo = ["email": user.email!, "password": password, "prenom": prenom, "nom": nom, "datedenaissance": datedenaissance, "uid": user.uid]
        
        let userRef = dataBaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo) { (error, ref) in
            if error == nil {
                print("User info save sucessfully")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func logIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                if let user = user {
                    print("\(user.displayName!) has logged in successfully")
                }
            } else {
                print(error?.localizedDescription)
            
            }
        }
    
    }
}
