//
//  UIImage+Assets.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import UIKit

extension UIImage {
    
    enum AppImage: String {
        case heart
        case noAccount
        case appleLogo
        case googleLogo
        case placeholder
        case profilePicture
        case backgroundProfile
    }
    
    enum SystemImage: String {
        case lock
        case plus
        case house
        case person
        case magnifyingglass
        case systemHeart = "heart"
        case heartFill = "heart.fill"
        case personFill = "person.fill"
        case playCircle = "play.circle"
        case envelopeFill = "envelope.fill"
        case chevronRight = "chevron.right"
        case personCropCircle = "person.crop.circle"
        case forkKnifeCircle = "fork.knife.circle"
        case doorLeftHandOpen = "door.left.hand.open"
    }
    
    convenience init?(_ image: AppImage) {
        self.init(named: image.rawValue)
    }
    
    convenience init?(_ systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
    
    convenience init?(_ systemImage: SystemImage, withConfiguration configuration: UIImage.Configuration?) {
        self.init(systemName: systemImage.rawValue, withConfiguration: configuration)
    }
    
}
