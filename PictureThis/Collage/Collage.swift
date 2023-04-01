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
              name: "Harjyot Badh",
              artworkUrl100: URL(string:"https://easydrawingguides.com/wp-content/uploads/2017/02/How-to-draw-a-cartoon-tree-20.png")!),
        Collage(title: "Airplane",
              name: "Harjyot Badh",
              artworkUrl100: URL(string: "https://artprojectsforkids.org/wp-content/uploads/2020/05/Airplane.jpg")!),
        Collage(title: "Car",
              name: "Harjyot Badh",
              artworkUrl100: URL(string: "https://howtodrawforkids.com/wp-content/uploads/2021/12/how-to-draw-a-car-for-kids.jpg")!)
    ]
    
    static var AnotherThing: [Collage]  = [
        Collage(title: "Tree", name: "Harjyot Badh", artworkUrl100: URL(string:"https://easydrawingguides.com/wp-content/uploads/2017/02/How-to-draw-a-cartoon-tree-20.png")!),
        Collage(title: "Ocean", name: "Person Two", artworkUrl100: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLLPeIOAhUQit-zA_oTltnC9XYnhgOVlfIr_dq0DQg4A&s")!),
        Collage(title: "Planet", name: "Person Two", artworkUrl100: URL(string: "https://howtodrawforkids.com/wp-content/uploads/2022/01/9-jupiter-drawing-cartoon.jpg")!),
        Collage(title: "Airplane",
              name: "Harjyot Badh",
              artworkUrl100: URL(string: "https://artprojectsforkids.org/wp-content/uploads/2020/05/Airplane.jpg")!),
        Collage(title: "Pirate Ship", name: "Person Three", artworkUrl100: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcei5WerUsM8XfPFfpoLeq6pH6GtpvDtVQof6ddOjqeg&s")!),
        Collage(title: "Car",
              name: "Harjyot Badh",
              artworkUrl100: URL(string: "https://howtodrawforkids.com/wp-content/uploads/2021/12/how-to-draw-a-car-for-kids.jpg")!)
    ]

}
