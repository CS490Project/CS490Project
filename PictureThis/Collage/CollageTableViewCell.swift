//
//  CollageTableViewCell.swift
//  PictureThis
//
//  Created by Harjyot Badh on 3/24/23.
//

import UIKit
import Nuke

class CollageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collageImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Configures the cell's UI for the given track.
    func configure(with collage: Collage) {
        titleLabel.text = collage.title
        nameLabel.text = collage.name
        collageImage.image = collage.artworkUrl100
        // Load image async via Nuke library image loading helper method
//        Nuke.loadImage(with: collage.artworkUrl100, into: collageImage)
    }
    

}
