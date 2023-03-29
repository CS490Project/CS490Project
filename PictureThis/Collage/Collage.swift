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
    var artworkUrl100: URL
    
}

extension Collage {

    /// An array of mock tracks
    static var mockCollages: [Collage]  = [
        Collage(title: "Tree",
              name: "Some random person",
              artworkUrl100: URL(string:"https://easydrawingguides.com/wp-content/uploads/2017/02/How-to-draw-a-cartoon-tree-20.png")!),
        Collage(title: "Airplane",
              name: "Another person",
              artworkUrl100: URL(string: "https://artprojectsforkids.org/wp-content/uploads/2020/05/Airplane.jpg")!),
        Collage(title: "Car",
              name: "Anothe random person",
              artworkUrl100: URL(string: "https://howtodrawforkids.com/wp-content/uploads/2021/12/how-to-draw-a-car-for-kids.jpg")!)
    ]

    // We can now access this array of mock tracks anywhere like this:
    // let tracks = Tracks.mockTracks
}
