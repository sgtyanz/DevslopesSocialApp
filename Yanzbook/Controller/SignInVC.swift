//
//  ViewController.swift
//  Yanzbook
//
//  Created by Yancarlo Rivera on 1-Jan-2018.
//  Copyright © 2018 SGT Mobile Apps. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper


class SingInVC: UIViewController {
    
    @IBOutlet weak var emailField: CustomUITextField!
    @IBOutlet weak var passwordField: CustomUITextField!
    @IBOutlet weak var emailAndPasswordErrorLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if KeychainWrapper.standard.string(forKey: "uid") != nil {
            if FIRAuth.auth()?.currentUser == nil {
                let _ = KeychainWrapper.standard.removeAllKeys()
                print("YAN: Removed the auto-login Keychain")
            } else {
                print("YAN: Found an ID in Keychain. Auto login is ENABLED.")
                performSegue(withIdentifier: "showFeedVC", sender: nil)
            }
        }
        
        if KeychainWrapper.standard.string(forKey: "uid") == nil {
            print("YAN: Found nil in Keychain. Auto-login is DISABLED.")
        }
        
    }


    @IBAction func facebookBtnPressed(_ sender: Any) {
        performFacebookLogin()
    }
    
    @IBAction func LoginBtnPressed(_ sender: Any) {
        //performFirebaseLogin()
    }
    
    func performFacebookLogin() {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if error != nil {
                print("YAN: Unable to authenticate with Facebook! - \(error.debugDescription)")
            } else if result?.isCancelled == true {
                print("YAN: User cancelled Facebook Authentication")
            } else {
                print("YAN: Successfully authenticated with Facebook")
                let fbAccessToken = FBSDKAccessToken.current().tokenString
                let fbCrendential = FIRFacebookAuthProvider.credential(withAccessToken: fbAccessToken!)
                self.firebaseAuth(credential: fbCrendential)
                
            }
        })

    }
    
    func performFirebaseLogin() {
        
        let email = emailField.text!
        let password = passwordField.text!
        
        if email != "", password != "" {
            //Firebase email and password Login logic
            
            checkEmailAndPassword(email: email, password: password)
            print("Firebase login logic running...")
            
            
            
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    
                    let userID = user?.uid
                    let saveAccount: Bool = KeychainWrapper.standard.set(userID!, forKey: "uid")
                    print("YAN: Succesfully Logged in with Email and password")
                    print("YAN: uid\(userID!) - saveAccount \(saveAccount)")
                }
            })
            
        } else {
            print("Email and Password Error...")
            checkEmailAndPassword(email: email, password: password)
        }
        
        
    }
    
    func checkEmailAndPassword(email: String, password: String) {
        if email == "", password == "" {
            emailAndPasswordErrorLabel.isHidden = false
            emailAndPasswordErrorLabel.text = "Please enter both, email address and password..."
            emailField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderColor = UIColor.red.cgColor
        } else if email == "" {
            emailAndPasswordErrorLabel.isHidden = false
            emailAndPasswordErrorLabel.text = "Please enter the email address..."
            emailField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderColor = UIColor.darkGray.cgColor
        } else if password == "" {
            emailAndPasswordErrorLabel.isHidden = false
            emailAndPasswordErrorLabel.text = "Please enter the password..."
            passwordField.layer.borderColor = UIColor.red.cgColor
            emailField.layer.borderColor = UIColor.darkGray.cgColor
        } else {
            emailAndPasswordErrorLabel.isHidden = true
            emailField.layer.borderColor = UIColor.darkGray.cgColor
            passwordField.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    func firebaseAuth(credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("YAN: Unable to authenticated with Firebase - \(error.debugDescription)")
            } else {
                
                let userAccount = UserAccountDetails()
                
                let userID = user?.uid
                let saveAccount = KeychainWrapper.standard.set(userID!, forKey: "uid")
                let userEmail = FIRAuth.auth()?.currentUser?.email
                let userDisplayName = FIRAuth.auth()?.currentUser?.displayName
                print("YAN: Successfully authenticated with Firebase")
                print("YAN: userID: \(userID!) - saveAccount: \(saveAccount)")
                
                userAccount.email = userEmail!
                userAccount.displayName = userDisplayName!
                userAccount.userID = userID!
                userAccount.accountType = "Facebook Account logged in."
                
                self.performSegue(withIdentifier: "showFeedVC", sender: nil)
            }
        })
    }
    
}

