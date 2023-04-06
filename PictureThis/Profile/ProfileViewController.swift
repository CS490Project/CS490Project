//
//  ProfileViewController.swift
//  PictureThis
//
//  Created by Harjyot Badh on 3/30/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser!.uid

        let docRef = db.collection("users").document(userID)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.nameLabel.text = data["name"] as? String ?? ""
                }
            }
        }
    
        
        // @TODO: Have the user set their own profile picture, by clicking the image.
        
        // @TODO: Have the correct image appear, if the user does not have an image, then have a default image.
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
