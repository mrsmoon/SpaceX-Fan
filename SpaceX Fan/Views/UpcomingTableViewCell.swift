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
    @IBOutlet weak var descriptionTopLabel: UILabel!
    @IBOutlet weak var descriptionBottomLabel: UILabel!
    @IBOutlet weak var upcomingImage: UIImageView!
    
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
        
    }
    
    //TODO: Send item info as a parameter here
    func populateCell(isCellIndexEven: Bool) {
        if isCellIndexEven {
            exploreButtonColored.isHidden = true
            titleBottomLabel.isHidden = true
            descriptionBottomLabel.isHidden = true
            exploreButtonWhite.isHidden = false
            titleTopLabel.isHidden = false
            descriptionTopLabel.isHidden = false
        } else {
            exploreButtonWhite.isHidden = true
            titleTopLabel.isHidden = true
            descriptionTopLabel.isHidden = true
            exploreButtonColored.isHidden = false
            titleBottomLabel.isHidden = false
            descriptionBottomLabel.isHidden = false
        }
    }
    
    override func prepareForReuse() {
        exploreButtonColored.isHidden = true
        titleBottomLabel.isHidden = true
        descriptionBottomLabel.isHidden = true
        exploreButtonWhite.isHidden = true
        titleTopLabel.isHidden = true
        descriptionTopLabel.isHidden = true
        //TODO: open it later
        //upcomingImage.image = nil
    }

}
