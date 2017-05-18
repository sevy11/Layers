//
//  LYError.swift
//  Layers
//
//  Created by Michael Sevy on 5/8/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import Foundation
/**
    A class entity representing an error that
    the API would return or an internal error
    in the application.
 */
final class LYError: Error {

    // MARK: - Attributes
    let statusCode: Int
    let errorDescription: String


    // MARK: - Initializers

    /**
        Initializes an instance of `BaseError` with
        a given status code and an error description.

        - Parameters:
            - statusCode: An `Int` representing the status
                          code of the response. The status
                          code would usually be within the
                          four hundred to five hundred.
            - errorDescription: A `String` representing the
                                description of the error given
                                from the API.
     */
    init(statusCode: Int, errorDescription: String) {
        self.statusCode = statusCode
        self.errorDescription = errorDescription
    }
}


// MARK: - Public Class Methods
extension LYError {

    /**
    Takes an error dictionary returned from the
    API and gets the error description.

     - Parameters: errorDictionary: An `[String: Any]` representing
                                      the error dictionary returned from
                                      the API.

     - Returns: A `String` representing the error description. If the
                dictionary can't be parsed, a default error description
                will be returned.
     */
    class func errorDescriptionFromErrorDictionary(_ errorDictionary: [String: Any]) -> String {
        if let usernameErrors = errorDictionary["username"] as? [String],
            let usernameError = usernameErrors.first {
            return usernameError + " 😞"
        }
        if let userIdErrors = errorDictionary["id"] as? [String],
            let userIdError = userIdErrors.first {
            return userIdError + " 😞"
        }
        if let firstNameErrors = errorDictionary["first_name"] as? [String],
            let firstNameError = firstNameErrors.first {
            return firstNameError + " 😞"
        }
        if let lastNameErrors = errorDictionary["last_name"] as? [String],
            let lastNameError = lastNameErrors.first {
            return lastNameError + " 😞"
        }
        if let phoneErrors = errorDictionary["phone"] as? [String],
            let phoneError = phoneErrors.first {
            return phoneError + " 😞"
        }
        if let birthDateErrors = errorDictionary["birth_date"] as? [String],
            let birthDateError = birthDateErrors.first {
            return birthDateError + " 😞"
        }
        if let emailErrors = errorDictionary["email"] as? [String],
            let emailError = emailErrors.first {
            return emailError + " 😞"
        }
        if let emailError = errorDictionary["email"] as? String {
            return emailError + " 😞"
        }
        if let genderErrors = errorDictionary["gender"] as? [String],
            let genderError = genderErrors.first {
            return genderError + " 😞"
        }
        if let tokenErrors = errorDictionary["token"] as? [String],
            let tokenError = tokenErrors.first {
            return tokenError + " 😞"
        }
        if let passwordErrors = errorDictionary["password"] as? [String],
            let passwordError = passwordErrors.first {
            return passwordError + " 😞"
        }
        if let photoErrors = errorDictionary["photo"] as? [String],
            let photoError = photoErrors.first {
            return photoError + " 😞"
        }
        if let nonFieldErrors = errorDictionary["non_field_errors"] as? [String],
            let nonFieldError = nonFieldErrors.first {
            return nonFieldError + " 😞"
        }
        if let detailErrors = errorDictionary["detail"] as? [String],
            let detailError = detailErrors.first {
            return detailError + " 😞"
        }
        if let imageErrors = errorDictionary["image"] as? [String],
            let imageError = imageErrors.first {
            return imageError + " 😞"
        }
        if let providerErrors = errorDictionary["provider"] as? [String],
            let providerError = providerErrors.first {
            return providerError
        }
        return NSLocalizedString("BaseError.DefaultErrorDescription", comment: "Default Error")
    }
}


// MARK: - Internal Errors
extension LYError {
    static var generic: LYError {
        return LYError(statusCode: 0, errorDescription: NSLocalizedString("BaseError.DefaultErrorDescription", comment: "Default Error"))
    }

    static var fieldsEmpty: LYError {
        return LYError(statusCode: 101, errorDescription: NSLocalizedString("BaseError.FieldsMissing", comment: "Default Error"))
    }

    static var passwordsDoNotMatch: LYError {
        return LYError(statusCode: 102, errorDescription: NSLocalizedString("BaseError.PasswordsDoNotMatch", comment: "Default Error"))
    }

    static var emailNeededForOAuth: LYError {
        return LYError(statusCode: 103, errorDescription: NSLocalizedString("BaseError.EmailNeededForOAuth", comment: "Default Error"))
    }

    static var emailAlreadyInUseForOAuth: LYError {
        return LYError(statusCode: 104, errorDescription: NSLocalizedString("BaseError.EmailAlreadyInUseForOAuth", comment: "Default Error"))
    }

    static var emailNeededForOAuthFacebook: LYError {
        return LYError(statusCode: 105, errorDescription: NSLocalizedString("BaseError.EmailNeededForOAuth", comment: "Default Error"))
    }

    static var emailNeededForOAuthLinkedIn: LYError {
        return LYError(statusCode: 106, errorDescription: NSLocalizedString("BaseError.EmailNeededForOAuth", comment: "Default Error"))
    }

    static var emailNeededForOAuthTwitter: LYError {
        return LYError(statusCode: 107, errorDescription: NSLocalizedString("BaseError.EmailNeededForOAuth", comment: "Default Error"))
    }

    static var endOfPagination: LYError {
        return LYError(statusCode: 108, errorDescription: NSLocalizedString("BaseError.EndOfPagination", comment: "Default Error"))
    }

    static var stillLoadingResults: LYError {
        return LYError(statusCode: 109, errorDescription: NSLocalizedString("BaseError.StillLoadingResults", comment: "Default Error"))
    }

    static var newEmailConfirmed: LYError {
        return LYError(statusCode: 110, errorDescription: NSLocalizedString("BaseError.NewEmailConfirmed", comment: "Default Error"))
    }

    static var fetchResultsError: LYError {
        return LYError(statusCode: 111, errorDescription: NSLocalizedString("BaseError.FetchResultsError", comment: "Default Error"))
    }
}
