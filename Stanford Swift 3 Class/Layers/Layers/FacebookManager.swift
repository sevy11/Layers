//
//  FacebookManager.swift
//  Layers
//
//  Created by Michael Sevy on 5/8/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import Foundation
import FBSDKShareKit
import FBSDKLoginKit

/**
 A singleton responsible for facebook operations.
 */
final class FacebookManager {

    // MARK: - Shared Instance
    static let shared = FacebookManager()


    // MARK: - Initializers

    /**
     Initializes a shared instance of `FacebookManager`.
     */
    private init() {}
}


// MARK: - Public Instance Methods
extension FacebookManager {

    /**
     activates the Facebook App Events SDK
     */
    func activate() {
        FBSDKAppEvents.activateApp()
    }

    /**
     instance of a Facebook Login Manager
     */
    func loginManager() -> FBSDKLoginManager {
        let loginManager = FBSDKLoginManager()
        return loginManager
    }

    /**
     initializes the facebook application delegate
     */
    func initializeDelegate(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    /**
     initializes the facebook url delegate
     */
    func initializeURLDelegate(application: UIApplication, url: URL, options:[UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    /**
     initialize Source Application delegate
     */
    func initializeSourceApplicationDelegate(application: UIApplication, url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    /**
     Fetches the relavant data for the Facebook user logged in.

     - Parameters:
         - token: A `String` representing the token received from
         a successful facebook login.
         - success: A closure that gets invoked when sending the
         request was successful.
         - failure: A closure that gets invoked when sending the
         request failed. Passes a `BaseError` object that
         contains the error that occured.
     */
    func fetchFacebookData(viewController: UIViewController,_ success: @escaping (FacebookUserInfo) -> Void, failure: @escaping (_ error: LYError) -> Void) {
        FacebookManager.shared.loginManager().logIn(withReadPermissions: ["public_profile", "email"], from: viewController) { (result, error) -> Void in
            if (result != nil) {
                if (result!.grantedPermissions.contains("email")) {
                    let params = ["fields": "email, cover, first_name, last_name"]
                    let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
                    graphRequest!.start(completionHandler: { (connection, result, error) -> Void in
                        if ((error) != nil) {
                            failure(error as! LYError)
                        } else {
                            typealias JSONDictionary = [String: Any]
                            let results = result as? [String:Any]
                            if let email = results?["email"] as? String?,
                                let firstName = results?["first_name"] as? String?,
                                let lastName = results?["last_name"] as? String?,
                                let cover = results?["cover"] as? [String:Any],
                                let avatarURL = cover["source"] as? String? {
                                success(FacebookUserInfo(email: email!, facebookAccessToken: FBSDKAccessToken.current().tokenString, firstName: firstName!, lastName: lastName!, avatarURL: avatarURL!))
                            }
                        }
                    })
                }
            }
        }
    }

//    func loginViaFacebook(facebookInfo: FacebookUserInfo) {
//        AuthenticationManager.shared.loginWithFacebookToken(facebookInfo.facebookAccessToken, success: { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.loginSuccess.value = true
//        }) { [weak self] (error: BaseError) in
//            if error.statusCode == 404 {
//                AuthenticationManager.shared.signupForFacebook(facebookInfo, success: { [weak self] in
//                    guard let strongSelf = self else { return }
//                    strongSelf.loginSuccess.value = true
//                    NotificationCenter.default.post(name: .UserLoggedIn, object: nil)
//                }) { [weak self] (error: BaseError) in
//                    guard let strongSelf = self else { return }
//                    strongSelf.loginSuccess.value = false
//                }
//            }
//        }
//    }
}
