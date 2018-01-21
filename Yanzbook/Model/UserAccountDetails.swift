//
//  UserAccountDetails.swift
//  Yanzbook
//
//  Created by Yancarlo Rivera on 1-Jan-2018.
//  Copyright © 2018 SGT Mobile Apps. All rights reserved.
//

import Foundation


class UserAccountDetails {
    
    private var _email: String!
    private var _displayName: String!
    private var _userID: String!
    private var _accountType: String!
    
    var email: String {
        get {
            return _email
        } set {
            _email = newValue
        }
    }
    
    var displayName: String {
        get {
            return _displayName
        } set {
            _displayName = newValue
        }
    }
    
    var userID: String {
        get {
            return _userID
        } set {
            _userID = newValue
        }
    }
    
    var accountType: String {
        get {
            return _accountType
        } set {
            _accountType = newValue
        }
    }
    
    
}
