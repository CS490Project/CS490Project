//
//  FriendViewController.swift
//  PictureThis
//
//  Created by Harjyot Badh on 4/6/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FriendViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        
        if let text = usernameField.text, text.isEmpty {
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
        
        print("ONE")
        let usernameText = usernameField.text!.uppercased()
        
        print(usernameText)
        
        let db = Firestore.firestore()
        db.collection("users").whereField("name", isEqualTo: usernameText)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var doesExist = false
                    var document: QueryDocumentSnapshot? = nil
                    for searchDocument in querySnapshot!.documents {
                        print("\(searchDocument.documentID) => \(searchDocument.data())")
                        document = searchDocument
                        doesExist = true
                    }
                    
                    if (!doesExist) {
                        // Alert for if user could not be found.
                        let alertController = UIAlertController(title: "Alert", message: "User could not be found.", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) {
                            (action: UIAlertAction!) in
                            // Code in this block will trigger when OK button tapped.
                            print("Ok button tapped");
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion: nil)
                        print("username or pasword is nil!")
                        return
                    } else {
                        // Add friends to each other's friend's list.
                                            
                        let friendId = document!.documentID
                        let currentUserId = Auth.auth().currentUser?.uid ?? ""
                        
                        if (friendId == currentUserId) {
                            // Alert for if users are trying to add themselves.
                            let alertController = UIAlertController(title: "Alert", message: "You can not add yourself!", preferredStyle: .alert)
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
                        
                        // Check if the friend has already been added, if they have show an error message.
                        db.collection("users").document(currentUserId).getDocument { (userDocument, err) in
                            if let err = err {
                                print("Error getting user's document: \(err)")
                            } else {
                                guard let userDoc = userDocument, let friendsList = userDoc["friends"] as? [String] else { return }
                                
                                if friendsList.contains(friendId) {
                                    // Alert for if users are trying to add themselves.
                                    let alertController = UIAlertController(title: "Alert", message: "This friend has already been added.", preferredStyle: .alert)
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
                            }
                        }
                                            
                        // Add friend to user's friend list
                        db.collection("users").document(currentUserId).updateData(["friends":FieldValue.arrayUnion([friendId])]) { err in
                            if let err = err {
                                print("Error updating user's friend list: \(err)")
                            } else {
                                print("User's friend list successfully updated")
                            }
                        }
                                            
                        // Add user to friend's friend list
                        db.collection("users").document(friendId).updateData(["friends":FieldValue.arrayUnion([currentUserId])]) { err in
                            if let err = err {
                                print("Error updating friend's friend list: \(err)")
                            } else {
                                print("Friend's friend list successfully updated")
                            }
                        }
                        
                    } // else
                
                    
                }
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

}
