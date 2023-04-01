//
//  ViewController.swift
//  PictureThis
//
//  Created by Harjyot Badh on 3/6/23.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }

    @IBOutlet weak var usernameLabel: UITextField!
        
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        guard let username = usernameLabel.text,
              let password = passwordLabel.text,
              !username.isEmpty,
              !password.isEmpty
                
        else {
            print("username or pasword is nil!")
            return
        }
        
        Firebase.Auth.auth().signIn(withEmail: username, password: password) {
            result, error in if let e = error{
                print(e.localizedDescription)
                return
                
            }
            guard let res = result else {
                print("Error occured with ligging in ")
                return
            }
            print("Signed in as \(res.user.email)")
            self.performSegue(withIdentifier: "loginSeque", sender: nil)
        }
    }
    // sign up
    
    
    @IBOutlet weak var signUpUsernameLabel: UITextField!
    
    @IBOutlet weak var signUpPasswordLabel: UITextField!
    
    @IBOutlet weak var signUpSecondPasswordLabel: UITextField!
    
    
    @IBAction func onSignUp(_ sender: Any) {
        guard let username = signUpUsernameLabel.text,
              let password = signUpPasswordLabel.text else {
            print("username or pasword is nil!")
            return
        }
        
        Firebase.Auth.auth().createUser(withEmail: username, password: password) {
            result, error in if let e = error{
                print(e.localizedDescription)
                return
                
            }
            guard let res = result else {
                print("Error occured with ligging in ")
                return
            }
            print("Signed in as \(res.user.email)")
            self.performSegue(withIdentifier: "signUpSegue", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
