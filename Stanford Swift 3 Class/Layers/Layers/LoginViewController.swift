//
//  ViewController.swift
//  Layers
//
//  Created by Michael Sevy on 5/7/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: LYTextField!
    @IBOutlet weak var passwordTextField: LYTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    fileprivate var email: String!
    fileprivate var password: String!
    fileprivate var user: FIRUser?

    override func viewDidLoad() {
        super.viewDidLoad()

        email = ""
        password = ""
        if user?.displayName != nil {
            self.user = user!
        }

    }


    // MARK: - Private Instance Attributes
    fileprivate enum LoginButtons: Int, CaseCount {
        case login
        case facebook
        case createAccount
        case forgotPassword
        static let caseCount = LoginButtons.numberOfCases()
    }

    @IBAction private func baseButtonTapped(_ sender: UIButton) {
        guard let tag = LoginButtons(rawValue: sender.tag) else { return }
        switch tag {
        case .login:
            logInWithEmail(email: email, password: password)
            break
        case .facebook:
            //loginWithFacebook()
            break
        case .createAccount:
             performSegue(withIdentifier: UIStoryboardSegue.goToCreateAccountSegue, sender: nil)
            break
        case .forgotPassword:
            //    performSegue(withIdentifier: UIStoryboardSegue.goToForgotPasswordRequestSegue, sender: nil)
            break
        }
    }
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {

        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            if textField.text != nil {
                if isValidEmail(emailString: textField.text!) {
                    email = textField.text!
                } else {
                    self.usernameTextField.performShakeAnimation()
                }
            } else {
                self.usernameTextField.performShakeAnimation()
            }
        } else if textField == passwordTextField {
            if textField.text != nil {
                if (textField.text?.characters.count)! > 5 {
                    password = textField.text!
                } else {
                    self.passwordTextField.performShakeAnimation()
                }
            }
        }
    }
}


// MARK: - Public Instance Methods
extension LoginViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


// MARK: - Private Instance Methods
fileprivate extension LoginViewController {

    /// Login With Firebase User
    fileprivate func logInWithEmail(email: String, password: String) {
       AuthenticationManager.shared.login(email: email, password: password, success: { [weak self] (user) in
            guard let strongSelf = self else { return }
            strongSelf.user = user
            strongSelf.dismiss(animated: true, completion: nil)
       }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: true, completion: nil)
        }
    }

    func isValidEmail(emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailString)
    }

}
