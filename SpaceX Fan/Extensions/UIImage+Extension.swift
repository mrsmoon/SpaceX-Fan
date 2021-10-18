//
//  UIImage+Extension.swift
//  SpaceX Fan
//
//  Created by Sera on 10/15/21.
//

import UIKit

extension UIImage {
    static let starFill = UIImage(named: "favoriteStarActive")
    static let star = UIImage(named: "favoriteStarPassive")
    static let backBarButton = UIImage(named: "backButton")
    static let background = UIImage(named: "mainBackground")
    
    func blend(with image: UIImage) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let renderer = UIGraphicsImageRenderer(size: image.size)

        let result = renderer.image { ctx in
            // fill the background with white so that translucent colors get lighter
            UIColor.clear.set()
            ctx.fill(rect)

            image.draw(in: rect, blendMode: .normal, alpha: 1)
            self.draw(in: rect, blendMode: .lighten, alpha: 1)
        }
            
         return result
        
    }
}
