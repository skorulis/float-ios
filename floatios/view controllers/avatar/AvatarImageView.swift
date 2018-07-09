//
//  AvatarImageView.swift
//  floatios
//
//  Created by Alexander Skorulis on 10/7/18.
//  Copyright © 2018 Skorulis. All rights reserved.
//

import UIKit

extension String {
    func image(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

class AvatarImageView: UIImageView {

    func showAvatar(avatar:String,size:CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = size/2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
        self.image = avatar.image(size: CGSize(width: size, height: size))
        
    }
    
    
}
