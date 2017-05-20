//
//  User.swift
//  Layers
//
//  Created by Michael Sevy on 5/15/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import UIKit
import Firebase

final class User: FIRUser {


}

extension User {

    func authenticated() -> Bool {

        if FIRAuth.auth()?.currentUser != nil {
            return true
        }
        return false
    }



}
