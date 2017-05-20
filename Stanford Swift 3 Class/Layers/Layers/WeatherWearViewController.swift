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

    //var user: User?
    //move to mangaer
    var ref: FIRDatabaseReference!



    override func viewDidLoad() {
        super.viewDidLoad()
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            print("****\(String(describing: user.email))")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        user = FIRAuth.auth()?.currentUser as? User
//        if (user != nil) {
//            //call the weather api
//            print("*****: \(String(describing: user?.email))")
//        } else {
//            print("NO")
//            performSegue(withIdentifier: UIStoryboardSegue.goToLoginSegue, sender: self)
//        }
//        ref = FIRDatabase.database().reference()
    }


    //MARK: - View LifeCycle
    @IBAction func updateUser(_ sender: LYButton) {
        //let username = "Michael"
        //ref.child("users").child(currentUser.uid).setValue(["username": username])
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
    

