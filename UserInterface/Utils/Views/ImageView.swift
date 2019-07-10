//
//  Image.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import Foundation

@IBDesignable
class ImageView: UIImageView {
    
    @IBInspectable public var cornerRadius: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable public var borderWidth: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable public var borderColor: UIColor = .clear { didSet { setNeedsDisplay() } }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
}
