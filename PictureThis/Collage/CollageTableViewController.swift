//
//  CollageTableViewController.swift
//  PictureThis
//
//  Created by Harjyot Badh on 3/24/23.
//

import UIKit
import Nuke
import Firebase
import FirebaseAuth
import FirebaseStorage

class CollageTableViewController: UITableViewController {
    
    
    // Your data source, an array of Collage objects
    var collages: [Collage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCollages()
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCollages()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 5
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collages.count
    }
    
    // Changes the height of each cell.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollageTableViewCell", for: indexPath) as! CollageTableViewCell

        // Get the track that corresponds to the table view row
        let collage = collages[indexPath.row]

        // Configure the cell with it's associated track
        cell.configure(with: collage)
        

        // return the cell for display in the table view
        return cell
    }
    
    func loadCollages() {
        let uid = Auth.auth().currentUser!.uid
        let storageRef = Storage.storage().reference()
        let folderRef = storageRef.child("images/\(uid)")

        folderRef.listAll { (result, error) in
            if let error = error {
                print("Error retrieving files!!!!")
            } else {
                // Use DispatchGroup to wait for all asynchronous requests to finish before reloading the table view
                let group = DispatchGroup()

                for item in result!.items {
                    let fileRef = item

                    // Enter the DispatchGroup
                    group.enter()

                    fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            print(error)
                        } else {
                            if let data = data, let image = UIImage(data: data) {
                                self.collages.append(Collage(title: "Test", name: "Test", artworkUrl100: image))
                            }
                        }

                        // Leave the DispatchGroup
                        group.leave()
                    }
                }

                group.notify(queue: .main) {
                    self.tableView.reloadData()
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
