//
//  WeatherWearViewController.swift
//  Layers
//
//  Created by Michael Sevy on 5/16/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

final class WeatherWearViewController: UIViewController {

    var currentUser: FIRUser?
    var firDatabaseReference: FIRDatabaseReference!



    override func viewDidLoad() {
        super.viewDidLoad()

        let email = "michaelsevy+1@gmail.com"
        let password = "sevymich"

        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if (user != nil) {
                self.currentUser = user
                //print("user from call: \(user), user from local: \(self.currentUser)")
            }
            if (error != nil) {
                print("error: \(String(describing: error))")
            }
        })
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firDatabaseReference = FIRDatabase.database().reference()
    }


    //MARK: - View LifeCycle
    @IBAction func updateUser(_ sender: LYButton) {
        let newUsername = "Michael"
        self.firDatabaseReference.child("users").child(self.currentUser!.uid).setValue(["username": newUsername])
    }

    @IBAction func otherAction(_ sender: LYButton) {

    }

}
//MARK: - Navigation
//        if (user?.currentUser != nil) {
//            self.navigationItem.title = user?.displayName
//            print("user: \(String(describing: user?.currentUser))")
//        } else {
//            self.performSegue(withIdentifier: UIStoryboardSegue.goToLoginSegue, sender: self)
//        }
//    }
    

