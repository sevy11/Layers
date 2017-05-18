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

    var currentUser: FIRUser!
    var ref: FIRDatabaseReference!



    override func viewDidLoad() {
        super.viewDidLoad()

        let email = "michaelsevy@gmail.com"
        let password = "sevymich"

        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            guard let strongSelf = self else { return }
            if (user != nil) {
                strongSelf.currentUser = user!
            }
            if (error != nil) {
                print("error: \(String(describing: error))")
            }
        })
 

    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ref = FIRDatabase.database().reference()
    }


    //MARK: - View LifeCycle
    @IBAction func updateUser(_ sender: LYButton) {
        let username = "Michael"
        ref.child("users").child(currentUser.uid).setValue(["username": username])
    }

    @IBAction func otherAction(_ sender: LYButton) {
        performSegue(withIdentifier: UIStoryboardSegue.goToLoginSegue, sender: self)
    }

    @IBAction func readFIRFB(_ sender: UIButton) {

     //   var refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
       //     let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            // ...
        //})

    }

    @IBAction func updateFIRDB(_ sender: UIButton) {
        let newUsername = "Mikey"
        ref.child("users/(user.uid)/username").setValue(newUsername)
    }

    @IBAction func deleteFIRDB(_ sender: UIButton) {
    }

    //overwrite data: update a profile

}
//MARK: - Navigation
//        if (user?.currentUser != nil) {
//            self.navigationItem.title = user?.displayName
//            print("user: \(String(describing: user?.currentUser))")
//        } else {
//            self.performSegue(withIdentifier: UIStoryboardSegue.goToLoginSegue, sender: self)
//        }
//    }
    

