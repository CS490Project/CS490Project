//
//  Collage.swift
//  PictureThis
//
//  Created by Harjyot Badh on 3/24/23.
//

import Foundation
import UIKit

struct Collage {
    var title: String
    var name: String
    var artworkUrl100: UIImage
    var likeCount: Int
    var userID: String
    var imageName: String
    
    init(title: String, name: String, artworkUrl100: UIImage, likeCount: Int, userID: String, imageName: String) {
        self.title = title
        self.name = name
        self.artworkUrl100 = artworkUrl100
        self.likeCount = likeCount
        self.userID = userID
        self.imageName = imageName
    }
    
}
