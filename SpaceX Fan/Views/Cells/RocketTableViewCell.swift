//
//  RocketTableViewCell.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit
import SDWebImage

class RocketTableViewCell: UITableViewCell {

    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var rocket: RocketData? {
        didSet {
            rocketNameLabel.text = rocket?.getName().uppercased()
            let starImage = isFavorite ? UIImage.starFill : UIImage.star
            starButton.setImage(starImage, for: .normal)
            rocketImage.layer.cornerRadius = 16
            if let images = rocket?.getImages(), !images.isEmpty {
                rocketImage.sd_setImage(with: URL(string: images.first!), completed: nil)
            }
        }
    }
    
    var isFavorite = false
    
    var starClicked : (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        rocketNameLabel.text = ""
        rocketImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func starPressed(_ sender: UIButton) {
        if starButton.currentImage == UIImage.star {
            starButton.setImage(UIImage.starFill, for: .normal)
        } else {
            starButton.setImage(UIImage.star, for: .normal)
        }
        
        if let clicked = starClicked {
            clicked()
        }
    }
    
    override func prepareForReuse() {
        rocketNameLabel.text = ""
        rocketImage.image = nil
    }
}
