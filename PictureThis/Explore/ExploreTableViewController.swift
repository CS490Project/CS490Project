//
//  ExploreTableViewController.swift
//  PictureThis
//
//  Created by Harjyot Badh on 3/30/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ExploreTableViewController: UITableViewController {

    // Your data source, an array of Collage objects
    var collages: [Collage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // TODO: Pt 1 - Set tracks property with mock tracks array
        loadCollages()
        

        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collages.count
    }
    
    // Changes the height of each cell.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as! ExploreTableViewCell

        // Get the track that corresponds to the table view row
        let collage = collages[indexPath.row]

        // Configure the cell with it's associated track
        cell.configure(with: collage)
        

        // return the cell for display in the table view
        return cell
    }
    
    func loadCollages() {
        // Load your collages data here and populate the collages array
        // @TODO: Have all of the user's friends (or just all) collage appear here, by date.
//        collages = Collage.AnotherThing
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser?.uid
        db.collection("users").document(currentUser!).getDocument { (userDocument, err) in
            if let err = err {
                print("Error getting user's friends: \(err)")
            } else {
                guard let userDoc = userDocument, let friendsList = userDoc["friends"] as? [String] else {return}
                
                
                
                let storageRef = Storage.storage().reference()
                var tempImageArr: [UIImage] = []
                for id in friendsList {
                    let folderRef = storageRef.child("images/\(id)")
                    folderRef.listAll { (result, error) in
                        if let error = error {
                            print("Error retrieving files!!")
                        }
                        
                        for item in result!.items {
                            let fileRef = item
                            
                            fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                if let error = error {
                                    print(error)
                                } else {
                                    let image = UIImage(data: data!)
                                    
//                                    tempImageArr.append(image!)
                                    self.collages.append(Collage(title: "Test", name: "Test", artworkUrl100: image!))
                                    print(self.collages[0])
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        
                        
                    }
//                    tempImageArr.shuffle()
//                    print(tempImageArr.count)
                    
//                    for i in tempImageArr {
//
//                    }
                }
                
                
                
                
            }
            
            
            
            
        }
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
