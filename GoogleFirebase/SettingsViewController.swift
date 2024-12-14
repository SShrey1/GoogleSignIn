//
//  SettingsViewController.swift
//  GoogleFirebase
//
//  Created by user@59 on 14/12/2024.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var signOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        signOutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc func logoutTapped() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            print("Signed out")
            navigateToLogin()
        } catch let signoutError as NSError {
            print("Error signing outL %@", signoutError)
            
        }
            
        }
    
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "InViewController") as! InViewController
        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


