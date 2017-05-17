//
//  Constants.swift
//  Layers
//
//  Created by Michael Sevy on 5/8/17.
//  Copyright © 2017 Michael Sevy. All rights reserved.
//

import Foundation

/**
 An enum that defines constants used for
 configuration of the application.
 */
enum ConfigurationConstants {

    static let placeholder = "admin:admin@ds133281.mlab.com:33281/layers_db"
    static let herokuServerEndpoints = "https://evening-ocean-18307.herokuapp.com/ | https://git.heroku.com/evening-ocean-18307.git"
    // MARK: - File Constants
    static let globalConfiguration = "globalconfiguration"


    // MARK: - File Type Constants
    static let propertyListType = "plist"


    // MARK: - Environment Keys
    static let local = "Local"
    static let staging = "Staging"
    static let stable = "Stable"
    static let production = "Production"


    // MARK: - OAuth Keys
    static let appId = "AppId"
    static let redirectUri = "RedirectUri"


    // MARK: - Generic Keys
    static let apiUrl = "ApiUrl"
    static let crashlytics = "Crashlytics"
    static let facebook = "Facebook"
    static let linkedIn = "LinkedIn"
    static let twitter = "Twitter"
}

enum Weather {
    static let fiveDayForecastEndpoint = "api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}"
}
