//
//  RocketTableViewCell.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class RocketTableViewCell: UITableViewCell {

    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var rocketImage: UIImageView!
    
    var rocket: RocketData? {
        didSet {
            rocketNameLabel.text = rocket?.getName().uppercased()
            let starImage = isFavorite ? UIImage.starFill : UIImage.star
            starButton.setImage(starImage, for: .normal)
        }
    }
    
    var isFavorite = false
    
    var starClicked : (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        
        
        //TODO: Update favorite rocket list
    }
    
//    override func prepareForReuse() {
//        rocketNameLabel.text = ""
//        rocketImage.image = nil
//    }
}
