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
    
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        // TODO: Pt 1 - Set tracks property with mock tracks array
//        loadCollages()
//
//
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
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

        
        if (indexPath.row < collages.count) {
            // Get the collage that corresponds to the table view row
            let collage = collages[indexPath.row]
            
            // Configure the cell with it's associated collage
            cell.configure(with: collage)
        }
        

        

        // Set the delegate for the cell
        cell.delegate = self

        // Set the tag of the like button
        cell.likeButton.tag = indexPath.row

        return cell
    }
    
    
    
    
    
    func loadCollages() {
        collages.removeAll()

        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser?.uid
        if currentUser == nil {
            return
        }
        db.collection("users").document(currentUser!).getDocument { (userDocument, err) in
            if let err = err {
                print("Error getting user's friends: \(err)")
            } else {
                guard let userDoc = userDocument, let friendsList = userDoc["friends"] as? [String] else { return }

                let storageRef = Storage.storage().reference()
                let group = DispatchGroup()

                for id in friendsList {
                    group.enter()
                    print("Friend ID: \(id)")
                    let folderRef = storageRef.child("images/\(id)")
                    folderRef.listAll { (result, error) in
                        if let error = error {
                            print("Error retrieving files!!")
                        }

                        for item in result!.items {
                            print("item: \(item)")
                            group.enter()
                            let fileRef = item

                            // Retrieve the metadata
                            fileRef.getMetadata { metadata, error in
                                if let error = error {
                                    print("Error getting metadata: \(error)")
                                    group.leave()
                                } else if let metadata = metadata, let description = metadata.customMetadata?["description"] as? String {
                                    if let likeCountString = metadata.customMetadata?["likeCount"] as? String {
                                        let likeCount = Int(likeCountString) ?? 0

                                        db.collection("users").document(id).getDocument { (userDocument, err) in
                                            if let err = err {
                                                print("Error getting user's name: \(err)")
                                                group.leave()
                                            } else if let userDocument = userDocument, let userName = userDocument["name"] as? String {
                                                fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                                    if let error = error {
                                                        print(error)
                                                    } else {
                                                        if let imageData = data, let image = UIImage(data: imageData) {
                                                            self.collages.append(Collage(title: description, name: userName, artworkUrl100: image, likeCount: likeCount, userID: id, imageName: item.name))
                                                        }
                                                    }
                                                    group.leave()
                                                }
                                            } else {
                                                group.leave()
                                            }
                                        }
                                    } else {
                                        group.leave()
                                    }
                                } else {
                                    group.leave()
                                }
                            }
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    self.collages.sort { $0.likeCount > $1.likeCount }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    

}

// Declare the delegate protocol
protocol ExploreTableViewCellDelegate: AnyObject {
    func likeButtonTapped(at index: Int)
}

// Implement the protocol in your ExploreTableViewController
extension ExploreTableViewController: ExploreTableViewCellDelegate {
    func likeButtonTapped(at index: Int) {
        if index < collages.count {
            let collage = collages[index]
            let currentUserID = Auth.auth().currentUser?.uid ?? ""

            let db = Firestore.firestore()
            let likeRef = db.collection("likes").document("\(collage.userID)_\(collage.imageName)")

            likeRef.getDocument { document, error in
                if let document = document, document.exists {
                    if let data = document.data(), let likedUsers = data["likedUsers"] as? [String], !likedUsers.contains(currentUserID) {
                        self.incrementLikeCount(collage: collage, index: index)
                        likeRef.updateData(["likedUsers": FieldValue.arrayUnion([currentUserID])])
                    } else {
                        print("User has already liked this collage")
                    }
                } else {
                    self.incrementLikeCount(collage: collage, index: index)
                    likeRef.setData(["likedUsers": [currentUserID]])
                }
            }
        }
    }
    
    func incrementLikeCount(collage: Collage, index: Int) {
        collages[index].likeCount += 1

        // Update like count in Firebase
        let userID = collage.userID
        let imageName = collage.imageName
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/\(userID)/\(imageName)")

        imageRef.getMetadata { metadata, error in
            if let error = error {
                print("Error getting metadata: \(error)")
            } else if let metadata = metadata {
                // Update the metadata
                let updatedMetadata = StorageMetadata()
                updatedMetadata.customMetadata = [
                    "description": metadata.customMetadata?["description"] ?? "",
                    "likeCount": String(self.collages[index].likeCount)
                ]

                // Save the updated metadata
                imageRef.updateMetadata(updatedMetadata) { _, error in
                    if let error = error {
                        print("Error updating metadata: \(error)")
                    } else {
                        print("Metadata updated successfully")
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }




}

