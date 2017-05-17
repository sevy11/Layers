//
//  CreateAccountViewController.swift
//  Layers
//
//  Created by Michael Sevy on 5/15/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var createAccount: LYButton!
    @IBOutlet weak var confirmTextField: LYTextField!
    @IBOutlet weak var passwordTextField: LYTextField!
    @IBOutlet weak var emailTextField: LYTextField!
    fileprivate var email: String!
    fileprivate var password: String!
    fileprivate var confirm: String!
    fileprivate var user: FIRUser?
    fileprivate var passwordsMatch = false

    override func viewDidLoad() {
        super.viewDidLoad()

        email = ""
        password = ""
        if user?.displayName != nil {
            self.user = user!
        }
        self.confirmTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
    }


    @IBAction func createAccountTapped(_ sender: LYButton) {
        if self.passwordsMatch {
            createAccountWithEmail(email: email, password: password, { [weak self] (firebaseUser: FIRUser) in
                guard let strongSelf = self else { return }
                strongSelf.user = firebaseUser
                
            }) { [weak self] (error: LYError) in
                guard let strongSelf = self else { return }
                print("error: \(error)& \(strongSelf)")
            }
        } else {
            print("password match error")
            self.passwordTextField.performShakeAnimation()
        }
    }

}

// MARK: - UITextFieldDelegate
extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmTextField.becomeFirstResponder()
        } else {
            return true
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            if textField.text != nil {
                if isValidEmail(emailString: textField.text!) {
                    email = textField.text!
                } else {
                    self.emailTextField.performShakeAnimation()
                }
            } else {
                self.emailTextField.performShakeAnimation()
            }
        } else if textField == passwordTextField {
            if textField.text != nil {
                if (textField.text?.characters.count)! > 5 {
                    password = textField.text!
                } else {
                    self.passwordTextField.performShakeAnimation()
                }
            }
        } else if textField == confirmTextField {
            if textField.text != nil {
                confirm = textField.text!
            }
            if password == confirm {
                passwordsMatch = true
            } else {
                //show error alert for not matching passwords
            }
        }
    }


}


// MARK: - Public Instance Methods
extension CreateAccountViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


// MARK: - IBActions
fileprivate extension CreateAccountViewController {



}


// MARK: - Private Instance Methods
fileprivate extension CreateAccountViewController {

    fileprivate func createAccountWithEmail(email: String, password: String, _ success: @escaping (FIRUser) -> Void, failure: @escaping (_ error: LYError) -> Void) {

        //should put all this in FIR account manager
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            //var strongSelf = self else { return }
            if (user != nil) {
                print("user: \(user!)")
                success(user!)
            }
            if (error != nil) {
                print("error: \(error!)")
                failure(error as! LYError)
            }
        })

    }

    func isValidEmail(emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }
    
}
