//
//  UpcomingDetailTableViewCell.swift
//  SpaceX Fan
//
//  Created by Sera on 10/18/21.
//

import UIKit

class UpcomingDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var upcomingImage: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var upcomingImage2: UIImageView!
    
    var upcoming: UpcomingModel? {
        didSet {
            titleLabel.text = upcoming?.getName().uppercased()
            detailsLabel.text = upcoming?.getDetails()
            if let date = upcoming?.getDate() {
                numberLabel.text = date.0 >= 1 ? String(date.0) : ""
                timeLabel.text = date.0 > 1 ? date.1.uppercased() + "S" : date.1.uppercased()
            }
            
            let images = upcoming!.getLinks()
            
            if !images.isEmpty {
                upcomingImage.sd_setImage(with: URL(string: images.first!)) { (image, _, _, _) in
                    if let image = image {
                        self.upcomingImage.image = image.blend(with: UIImage.background!)
                        self.upcomingImage.contentMode = .scaleToFill
                    }
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        upcomingImage.image = nil
        upcomingImage2.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
