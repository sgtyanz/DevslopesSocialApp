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

class SingInVC: UIViewController {
    
    @IBOutlet weak var emailField: CustomUITextField!
    @IBOutlet weak var passwordField: CustomUITextField!
    @IBOutlet weak var emailAndPasswordErrorLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }


    @IBAction func facebookBtnPressed(_ sender: Any) {
        performFacebookLogin()
    }
    
    @IBAction func LoginBtnPressed(_ sender: Any) {
        performFirebaseLogin()
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
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {(user, error) in
                if error == nil {
                    
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
                print("YAN: Successfully authenticated with Firebase")
            }
        })
    }
    
}

