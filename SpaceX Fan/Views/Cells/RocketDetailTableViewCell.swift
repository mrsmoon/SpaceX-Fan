//
//  RocketDetailTableViewCell.swift
//  SpaceX Fan
//
//  Created by Sera on 10/17/21.
//

import UIKit

class RocketDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var diameterView: UIStackView!
    @IBOutlet weak var massView: UIStackView!
    @IBOutlet weak var featuresView: UIStackView!
    
    let viewModel = RocketDetailViewModel.shared
    
    var rocket: RocketData? {
        didSet {
            let starImage = isFavorite ? UIImage.starFill : UIImage.star
            starButton.setImage(starImage, for: .normal)
            descriptionLabel.text = rocket?.getDescription()
            descriptionLabel.sizeToFit()
            heightLabel.text = rocket?.getHeight()
            diameterLabel.text = rocket?.getDiameter()
            massLabel.text = rocket?.getMass()
            rocket?.getPayload().forEach({ (payload) in
                let titleLabel = UILabel()
                titleLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
                titleLabel.text  = "PAYLOAD TO \(payload.getId().uppercased())"
                titleLabel.font = UIFont(name: Constants.muliBold, size: 14)
                titleLabel.textColor = .white
                titleLabel.textAlignment = .left
                
                let valueLabel = UILabel()
                valueLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
                valueLabel.text  = payload.getPayloadKgLb()
                valueLabel.font = UIFont(name: Constants.muliRegular, size: 14)
                valueLabel.textColor = .white
                valueLabel.textAlignment = .right

                let stackView   = UIStackView()
                stackView.axis  = NSLayoutConstraint.Axis.horizontal
                stackView.distribution  = UIStackView.Distribution.fillEqually
                stackView.alignment = UIStackView.Alignment.fill
                stackView.spacing   = 0
                
                stackView.addTopBorder(with: .gray, andWidth: 1)
                stackView.addBottomBorder(with: .gray, andWidth: 1)
                
                stackView.addArrangedSubview(titleLabel)
                stackView.addArrangedSubview(valueLabel)
                stackView.translatesAutoresizingMaskIntoConstraints = false

                self.featuresView.addArrangedSubview(stackView)
            })
            
            heightView.addTopBorder(with: .gray, andWidth: 1)
            heightView.addBottomBorder(with: .gray, andWidth: 1)
            diameterView.addTopBorder(with: .gray, andWidth: 1)
            diameterView.addBottomBorder(with: .gray, andWidth: 1)
            massView.addTopBorder(with: .gray, andWidth: 1)
            massView.addBottomBorder(with: .gray, andWidth: 1)
            
            if let images = rocket?.getImages(), !images.isEmpty {
                rocketImage.sd_setImage(with: URL(string: images.first!), completed: nil)
            }
        }
    }
    
    var isFavorite = false
    
    var starClicked : (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        createLayout()
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
    }
    
    func createLayout() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 9, left: 12, bottom: 9, right: 12)
        collectionViewFlowLayout.minimumLineSpacing = 9
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }

}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension RocketDetailTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let imageCount = viewModel.currentRocket?.images.count {
            if imageCount > 1 {
                return imageCount - 1
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imageCellIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        if let images = rocket?.getImages(), !images.isEmpty {
            cell.imageView.sd_setImage(with: URL(string: images[indexPath.row + 1]), completed: nil)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension RocketDetailTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let collection = self.collectionView {
            let width = collection.bounds.width-24
            return CGSize(width: width, height: 180)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
