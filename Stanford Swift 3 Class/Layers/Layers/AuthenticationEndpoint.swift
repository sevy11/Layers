//
//  AuthenticationEndpoint.swift
//  Layers
//
//  Created by Michael Sevy on 5/8/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import Foundation
import Alamofire

/**
 An enum that conforms to `BaseEndpoint`. It defines
 endpoints that would be used for authentication.
 */
enum AuthenticationEndpoint: Int {
    case login
//    case loginFacebook(facebookAccessToken: String)
//    case signupFacebook(facebookInfo: FacebookUserInfo)
//    case signUp(signUpInfo: SignUpInfo)
//    case update(updateInfo: UpdateInfo, userId: Int)
    case currentUser
//    case oauth2(oauth2Info: OAuth2Info)
//    case oauth1Step1(oauth1Step1Info: OAuth1Step1Info)
//    case oauth1Step2(oauth1Step2Info: OAuth1Step2Info)
//    case forgotPasswordRequest(email: String)
//    case forgotPasswordReset(token: String, newPassword: String)
//    case changeEmailRequest(newEmail: String)
//    case changeEmailConfirm(token: String, userId: Int)
//    case changeEmailVerify(token: String, userId: Int)
//    case changePassword(currentPassword: String, newPassword: String)
//    case confirmEmail(token: String, userId: Int)

    var endpointInfo: Int {
//        let path: String
//        let requestMethod: Alamofire.HTTPMethod
//        let parameters: Alamofire.Parameters?
//        let parameterEncoding: Alamofire.ParameterEncoding?
//        let requiresAuthorization: Bool
        switch self {
        case .login:
            //do something : insert a URL for alamfire?
//            path = "login"
//            requestMethod = .post
//            parameters = ["email": email, "password": password]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
            break
//        case let .loginFacebook(facebookAccessToken):
//            path = "PicksUsers/login-facebook"
//            requestMethod = .post
//            parameters = ["facebookAccessToken": facebookAccessToken];
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .signupFacebook(facebookInfo):
//            path = "PicksUsers/signup-facebook"
//            requestMethod = .post
//            parameters = facebookInfo.parameters
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .signUp(signUpInfo):
//            path = "register"
//            requestMethod = .post
//            parameters = signUpInfo.parameters
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .update(updateInfo, userId):
//            path = "users/\(userId)"
//            requestMethod = .patch
//            parameters = updateInfo.parameters
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = true
//            break
        case .currentUser:
//            path = "PicksUsers/me"
//            requestMethod = .get
//            parameters = nil
//            parameterEncoding = nil
//            requiresAuthorization = true
            break
//        case let .oauth2(oauth2Info):
//            path = "social-auth"
//            requestMethod = .post
//            parameters = oauth2Info.parameters
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .oauth1Step1(oauth1Step1Info):
//            path = "social-auth"
//            requestMethod = .post
//            parameters = oauth1Step1Info.parameters
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .oauth1Step2(oauth1Step2Info):
//            path = "social-auth"
//            requestMethod = .post
//            parameters = oauth1Step2Info.parameters
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .forgotPasswordRequest(email):
//            path = "forgot-password"
//            requestMethod = .post
//            parameters = ["email": email]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .forgotPasswordReset(token, newPassword):
//            path = "forgot-password/reset"
//            requestMethod = .post
//            parameters = ["token": token, "new_password": newPassword]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .changeEmailRequest(newEmail):
//            path = "change-email"
//            requestMethod = .post
//            parameters = ["new_email": newEmail]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = true
//            break
//        case let .changeEmailConfirm(token, userId):
//            path = "change-email/\(userId)/confirm"
//            requestMethod = .post
//            parameters = ["token": token]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .changeEmailVerify(token, userId):
//            path = "change-email/\(userId)/verify"
//            requestMethod = .post
//            parameters = ["token": token]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
//        case let .changePassword(currentPassword, newPassword):
//            path = "users/change-password"
//            requestMethod = .post
//            parameters = ["current_password": currentPassword, "new_password": newPassword]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = true
//            break
//        case let .confirmEmail(token, userId):
//            path = "users/\(userId)/confirm-email"
//            requestMethod = .post
//            parameters = ["token": token]
//            parameterEncoding = JSONEncoding()
//            requiresAuthorization = false
//            break
        }
//        return BaseEndpointInfo(path: path, requestMethod: requestMethod, parameters: parameters, parameterEncoding: parameterEncoding, requiresAuthorization: requiresAuthorization)
        return 1
    }
}


/**
 A struct encapsulating what information is needed
 when registering a user.
 */
struct SignUpInfo {

    // MARK: - Public Instance Attributes
    let email: String
    let password: String
    let referralCodeOfReferrer: String?


    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        var params: Parameters = [
            "email": email,
            "password": password
        ]
        if let referralCode = referralCodeOfReferrer {
            params["referral_code"] = referralCode
        }
        return params
    }


    // MARK: - Initializers

    /**
     Initializes an instance of `SignUpInfo`.

     - Parameters:
     - email: A `String` representing the email of the user.
     - password: A `String` representing the password that the
     user would enter when logging in.
     - referralCodeOfReferrer: A `String` representing the referral
     code of another user that referred the
     current user to the application. `nil` can
     be passed if referral code isn't being used.
     */
    init(email: String, password: String, referralCodeOfReferrer: String?) {
        self.email = email
        self.password = password
        self.referralCodeOfReferrer = referralCodeOfReferrer
    }
}


/**
 A struct encapsulating what information is needed
 when logging in a user via Facebook login.
 */
struct FacebookUserInfo {

    // MARK: - Public Instance Attributes
    let email: String
    let facebookAccessToken: String
    let firstName: String
    let lastName: String
    let avatarURL: String?

    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        var params: Parameters = [
            "email": email,
            "facebookAccessToken": facebookAccessToken,
            "firstName": firstName,
            "lastName": lastName
        ]
        if let avatarURLForUser = avatarURL {
            params["source"] = avatarURLForUser
        }
        return params
    }


    // MARK: - Initializers

    /**
     Initializes an instance of `LoginFBUserInfo`.

     - Parameters:
     - email: A `String` representing the email of the user, which represents their FB username/email.
     - password: A `String` representing the authToken received from a successfull FB login.
     - firstName: A `String` representing the first name of ther user from their FB public profile.
     - lastName: A `String` representing the last name of the user from their FB public profile.
     - avatarURL: A `String` representing the url of the user's avatar from their FB public profile.
     */
    init(email: String, facebookAccessToken: String, firstName: String, lastName: String, avatarURL: String?) {
        self.email = email
        self.facebookAccessToken = facebookAccessToken
        self.firstName = firstName
        self.lastName = lastName
        self.avatarURL = avatarURL
    }
}


/**
 A struct encapsulating what information is needed
 when updating a user.
 */
struct UpdateInfo {

    // MARK: - Public Instance Attributes
    let referralCodeOfReferrer: String?
    let avatarBaseString: String?
    let firstName: String
    let lastName: String


    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        var params: Parameters = [
            "first_name": firstName,
            "last_name": lastName
        ]
        if let baseString = avatarBaseString {
            params["avatar"] = baseString
        }
        if let referralCode = referralCodeOfReferrer {
            params["referral_code"] = referralCode
        }
        return params
    }


    // MARK: - Initializers

    /**
     Initializes an instance of `UpdateInfo`.

     - Parameters:
     - referralCodeOfReferrer: A `String` representing the referral
     code of another user that referred the
     current user to the application. This is
     used when the user signs up through social
     authentication. In regular email signup, `nil`
     would be passed.
     - avatarBaseString: A `String` representing the base sixty four representation
     of an image. `nil` can be passed if no imaged was selected
     or changed.
     - firstName: A `String` representing the first name of the user.
     - lastName: A `String` representing the last name of the user.
     */
    init(referralCodeOfReferrer: String?, avatarBaseString: String?, firstName: String, lastName: String) {
        self.referralCodeOfReferrer = referralCodeOfReferrer
        self.avatarBaseString = avatarBaseString
        self.firstName = firstName
        self.lastName = lastName
    }
}

/**
 A struct encapsulating what information is needed
 when doing OAuth2 Authentication.
 */
struct OAuth2Info {

    // MARK: - Public Instance Methods
    let provider: String
    let oauthCode: String
    let redirectUri: String
    let email: String?
    let referralCodeOfReferrer: String?


    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        var params: Parameters = [
            "provider": provider,
            "code": oauthCode,
            "redirect_uri": redirectUri
        ]
        if let userEmail = email {
            params["email"] = userEmail
        }
        if let referralCode = referralCodeOfReferrer {
            params["referral_code"] = referralCode
        }
        return params
    }


    // MARK: - Initializers

    /**
     Initializes an instance of `OAuth2Info`.

     - Parameters:
     - provider: An `OAuth2Provider` representing the type of
     OAuth provider used.
     - oauthCode: A `String` representing the OAuth authorization
     code that is received from an OAuth2 provider.
     - redirectUri: A `String` representing the redirect used
     for the provider.
     - email: A `String` representing the email of the user used
     for logining in to the provider. This value would be
     filled if an error occured due to an email not being
     used for login. `nil` can be passed as a parameter.
     - referralCodeOfReferrer: A `String` representing the referral code of
     another user that the referred the current user
     to the application. In some situations, if the
     referral code can't be supplied due to the
     `oauthCode` expiring, the `UpdateInfo` can be used
     to pass the referral code. This only avaliable for
     twenty four hours after the user logged in. `nil`
     can be passed as a parameter.
     */
    init(provider: OAuth2Provider, oauthCode: String, redirectUri: String, email: String?, referralCodeOfReferrer: String?) {
        self.provider = provider.rawValue
        self.oauthCode = oauthCode
        self.redirectUri = redirectUri
        self.email = email
        self.referralCodeOfReferrer = referralCodeOfReferrer
    }
}


/**
 A struct encapsulating what information is needed
 for completing step one of OAuth1 Authentication.

 - SeeAlso: https://developers.baseapp.tsl.io/users/social-auth/
 */
struct OAuth1Step1Info {

    // MARK: - Public Instance Attributes
    let provider: String
    let redirectUri: String


    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        let params: Parameters = [
            "provider": provider,
            "redirect_uri": redirectUri
        ]
        return params
    }


    // MARK: - Initializers

    /**
     Initiailizes an instance of `OAuth1Step1Info`.

     - Parameters:
     - provider: A `OAuth1Provider` representing the
     type of OAuth provider used.
     - redirectUri: A `String` representing the redirect
     used for the provider.
     */
    init(provider: OAuth1Provider, redirectUri: String) {
        self.provider = provider.rawValue
        self.redirectUri = redirectUri
    }
}


/**
 A struct encapsulating what information is needed
 for completing step two of OAuth1 Authentication.

 - SeeAlso: https://developers.baseapp.tsl.io/users/social-auth/
 */
struct OAuth1Step2Info {

    // MARK: - Public Instance Attributes
    let provider: String
    let oauthToken: String
    let oauthTokenSecret: String
    let oauthVerifier: String
    let email: String?
    let referralCodeOfReferrer: String?


    // MARK: - Getters & Setters
    var parameters: Alamofire.Parameters {
        var params = [
            "provider": provider,
            "oauth_token": oauthToken,
            "oauth_token_secret": oauthTokenSecret,
            "oauth_verifier": oauthVerifier
        ]
        if let userEmail = email {
            params["email"] = userEmail
        }
        if let referralCode = referralCodeOfReferrer {
            params["referral_code"] = referralCode
        }
        return params
    }


    // MARK: - Initializers

    /**
     Initializes an instance of `OAuth1Step2Info`.

     - Parameters:
     - provider: A `OAuth1Provider` representing the
     type of OAuth provider used.
     - oauthToken: A `String` representing the OAuth
     token recieved from the provider.
     - oauthTokenSecret: A `String` representing the secret
     used for the provider.
     - oauthVerifier: A `String` representing the verifier
     recieved from the provider.
     - email: A `String` representing the email of the user used
     for logining in to the provider. This value would be
     filled if an error occured due to an email not being
     used for login. `nil` can be passed as a parameter.
     - referralCodeOfReferrer: A `String` representing the referral code of
     another user that the referred the current user
     to the application. In some situations, if the
     referral code can't be supplied due to the
     `oauthToken` expiring, the `UpdateInfo` can be used
     to pass the referral code. This only avaliable for
     twenty four hours after the user logged in. `nil`
     can be passed as a parameter.
     */
    init(provider: OAuth1Provider, oauthToken: String, oauthTokenSecret: String, oauthVerifier: String, email: String?, referralCodeOfReferrer: String?) {
        self.provider = provider.rawValue
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.oauthVerifier = oauthVerifier
        self.email = email
        self.referralCodeOfReferrer = referralCodeOfReferrer
    }
}


/**
 An enum that specifies the
 type of OAuth2 provider.
 */
enum OAuth2Provider: String {
    case facebook = "facebook"
    case linkedIn = "linkedin-oauth2"
}


/**
 An enum that specifies the
 type of OAuth1 provider.
 */
enum OAuth1Provider: String {
    case twitter = "twitter"
}
