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
    
    var upcoming: UpcomingModel? {
        didSet {
            titleLabel.text = upcoming?.getName()
            detailsLabel.text = upcoming?.getDetails()
            if let date = upcoming?.getDate() {
                numberLabel.text = date.0 >= 1 ? String(date.0) : ""
                timeLabel.text = date.0 > 1 ? date.1.uppercased() + "S" : date.1.uppercased()
            }
            
            upcomingImage.image = UIImage(named: "image2")?.blend(with: UIImage.background!)
            upcomingImage.contentMode = .scaleToFill
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
