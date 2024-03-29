//
//  Button.swift
//  KitmanLabsTest
//
//  Created by Fernando Moya de Rivas on 10/07/2019.
//  Copyright © 2019 fmoyader. All rights reserved.
//

import UIKit

@IBDesignable
public class Button: UIButton {
    
    @IBInspectable public var cornerRadius: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable public var borderWidth: CGFloat = 0 { didSet { setNeedsDisplay() } }
    @IBInspectable public var borderColor: UIColor = .clear { didSet { setNeedsDisplay() } }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
