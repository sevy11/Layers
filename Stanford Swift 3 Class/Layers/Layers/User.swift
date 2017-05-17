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

    var currentUser: String? {
        get {
            if let email = email {
                return email
            }
            return nil
        }
    }
}
