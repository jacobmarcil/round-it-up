//
//  User.swift
//  Micro-Investment
//
//  Created by Jacob Marcil on 2017-07-04.
//  Copyright © 2017 ETS. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User{

    var email: String?
    var prenom: String?
    var nom: String?
    var uid: String!
    var datedenaissance: String?
    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
        
        let userDict = snapshot.value as! [String: Any]
        
        key = snapshot.key
        ref = snapshot.ref
        email = userDict["email"] as? String
        prenom = userDict["prenom"] as? String
        nom = userDict["nom"] as? String
        datedenaissance = userDict["datedenaissance"] as? String
        uid = userDict["uid"] as? String
    
    
    }
    
    init(prenom: String, nom: String, datedenaissance: String, email: String, userId: String){
        self.prenom = prenom
        self.nom = nom
        self.datedenaissance = datedenaissance
        self.email = email
        self.uid = userId
    }
}
