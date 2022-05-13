//
//  extensions.swift
//  airelibre
//
//  Created by LucasG on 2022-05-05.
//

import Foundation
import UIKit


extension UIView {
    
    @IBInspectable var cornerRadiusTop: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }

}
