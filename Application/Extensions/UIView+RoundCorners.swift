//
//  UIView+RoundCorners.swift
//  Src
//
//  Created by BobaHasseb on 8/5/20.
//  Copyright © 2020 BobaHasseb. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundViewCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCorners(radius: CGFloat, corners: CACornerMask ) {
          self.layer.cornerRadius = CGFloat(radius)
          self.clipsToBounds = true
          self.layer.maskedCorners = corners
      }
}
