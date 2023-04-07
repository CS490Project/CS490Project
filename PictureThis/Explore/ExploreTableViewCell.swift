//
//  ExploreTableViewCell.swift
//  PictureThis
//
//  Created by Saarth Chaturvedi on 4/7/23.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exploreImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with collage: Collage) {
        title.text = collage.title
        userName.text = collage.name
        exploreImage.image = collage.artworkUrl100

    }
}
