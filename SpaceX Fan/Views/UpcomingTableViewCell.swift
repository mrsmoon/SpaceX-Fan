//
//  UpcomingTableViewCell.swift
//  SpaceX Fan
//
//  Created by Sera on 10/14/21.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exploreButtonWhite: UIButton!
    @IBOutlet weak var exploreButtonColored: UIButton!
    @IBOutlet weak var titleTopLabel: UILabel!
    @IBOutlet weak var titleBottomLabel: UILabel!
    @IBOutlet weak var upcomingImage: UIImageView!
    
    var exploreClicked : (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        exploreButtonColored.layer.cornerRadius = 22
        exploreButtonWhite.layer.cornerRadius = 22
        exploreButtonColored.layer.borderWidth = 0.3
        exploreButtonColored.layer.borderColor = UIColor.exploreButtonBorderColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func exploreButtonClicked() {
        if let clicked = exploreClicked {
            clicked()
        }
    }
    
    func populateCell(with upcoming: UpcomingModel, isCellIndexEven: Bool) {
        if isCellIndexEven {
            exploreButtonColored.isHidden = true
            titleBottomLabel.isHidden = true
            exploreButtonWhite.isHidden = false
            titleTopLabel.isHidden = false
            titleTopLabel.text = upcoming.getName().uppercased()
        } else {
            exploreButtonWhite.isHidden = true
            titleTopLabel.isHidden = true
            exploreButtonColored.isHidden = false
            titleBottomLabel.isHidden = false
            titleBottomLabel.text = upcoming.getName().uppercased()
        }
    }
    
    override func prepareForReuse() {
        exploreButtonColored.isHidden = true
        titleBottomLabel.isHidden = true
        exploreButtonWhite.isHidden = true
        titleTopLabel.isHidden = true
        //TODO: open it later
        //upcomingImage.image = nil
    }

}
