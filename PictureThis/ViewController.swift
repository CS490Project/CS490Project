//
//  ViewController.swift
//  PictureThis
//
//  Created by Harjyot Badh on 3/6/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        // @TODO: Add signout stuff here
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        print("Sign out success")
        
    }

    @IBOutlet weak var usernameLabel: UITextField!
        
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        guard let username = usernameLabel.text,
              let password = passwordLabel.text,
              !username.isEmpty,
              !password.isEmpty
                
        else {
            // Alert for unfilled fields.
            let alertController = UIAlertController(title: "Alert", message: "Ensure all fields are correctly filled.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            print("username or pasword is nil!")
            return
        }
        
        Firebase.Auth.auth().signIn(withEmail: username, password: password) {
            result, error in if let e = error{
                let alertController = UIAlertController(title: "Alert", message: "Error Logging In. Ensure all fields entered are correct.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                print(e.localizedDescription)
                return
                
            }
            guard let res = result
            else {
                let alertController = UIAlertController(title: "Alert", message: "Error Logging In. Ensure all fields entered are correct.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                print("Error occured with logging in ")
                return
            }
            print("Signed in as \(res.user.email)")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
            // Clear the fields on login success.
            self.usernameLabel.text = ""
            self.passwordLabel.text = ""
        }
    }
    
    
    // Sign Up ==================

    
    
    @IBOutlet weak var signUpUsernameLabel: UITextField!
    
    @IBOutlet weak var signUpPasswordLabel: UITextField!
    
    @IBOutlet weak var signUpSecondPasswordLabel: UITextField!
    
    
    @IBOutlet weak var nameField: UITextField!
    
    
    @IBAction func onSignUp(_ sender: Any) {
        guard let username = signUpUsernameLabel.text,
              let password = signUpPasswordLabel.text,
              let password2 = signUpSecondPasswordLabel.text,
              let name = nameField.text,
              !username.isEmpty,
              !password.isEmpty,
              !password2.isEmpty,
              !name.isEmpty
        else {
            // Alert for if all fields are not filled.
            let alertController = UIAlertController(title: "Alert", message: "Ensure all fields are correctly filled.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            print("username or pasword is nil!")
            return
        }
        
        // Check if both passwords are equal
        if (signUpPasswordLabel.text != signUpSecondPasswordLabel.text) {
            let alertController = UIAlertController(title: "Alert", message: "Ensure that passwords match!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            print("passwords do not match!")
            return
        }
        
        Firebase.Auth.auth().createUser(withEmail: username, password: password) {
            result, error in if let e = error{
                let alertController = UIAlertController(title: "Alert", message: "Error Signing Up. Ensure all fields entered are correct.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                print("Error occured with signing up")
                print(e.localizedDescription)
                return
                
            }
            guard let res = result else {
                let alertController = UIAlertController(title: "Alert", message: "Error Signing Up. Ensure all fields entered are correct.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
                print("Error occured with signing up")
                return
            }
            
            let db = Firestore.firestore()
            
            let userID = Auth.auth().currentUser!.uid
        
            
            // Add a new document in collection "users"
            db.collection("users").document(userID).setData([
                "name": self.nameField.text!.uppercased(),
                "profilePicURL": "null",
                "userID" : userID
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            
            self.signUpUsernameLabel.text = ""
            self.signUpPasswordLabel.text = ""
            self.signUpSecondPasswordLabel.text = ""
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
