//
//  FeedVC.swift
//  Yanzbook
//
//  Created by Yancarlo Rivera on 1-Jan-2018.
//  Copyright © 2018 SGT Mobile Apps. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {
    
    var userAccount: UserAccountDetails!
    
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userDisplayPhoto: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserAccountDetails()
        
        
    }
    @IBAction func logoutBtnPressed(_ sender: Any) {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print("YAN: Logout error: \(error.debugDescription)")
        }
        
        
        let _ = KeychainWrapper.standard.removeAllKeys()
        print("YAN: Succesfully Logged out!")
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func loadUserAccountDetails() {
        displayNameLabel.text = FIRAuth.auth()?.currentUser?.displayName
        emailLabel.text = FIRAuth.auth()?.currentUser?.email
        userIdLabel.text = FIRAuth.auth()?.currentUser?.uid
        let userImgUrl = FIRAuth.auth()?.currentUser?.photoURL
        
        if let data = try? Data(contentsOf: userImgUrl!) {
            self.userDisplayPhoto.image = UIImage(data: data)
        }
    }


}
