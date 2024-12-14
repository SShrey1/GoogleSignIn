//
//  ViewController.swift
//  GoogleFirebase
//
//  Created by user@59 on 14/12/2024.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class ViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("Missing client id")
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        signInButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
        
        checkUserSignInStatus()
        // Do any additional setup after loading the view.
    }
    
    @objc func signInWithGoogle() {
        print("Sign In Button Tapped")
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                print("Error signing in : \(error.localizedDescription)")
                return
            }
            
            guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else {
                print("No User or id token")
                return
                
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error authenticating : \(error.localizedDescription)")
                    return
                }
                
                print("User signed in : \(authResult?.user.uid ?? "")")
                self.showHomeScreen()
                
            }
            
            
            }
        }
    
    
    func checkUserSignInStatus() {
        if Auth.auth().currentUser != nil {
            showHomeScreen()
        }
    }
    
    func showHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
        
    }




