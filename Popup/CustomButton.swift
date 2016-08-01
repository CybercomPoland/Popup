//
//  DoroButton.swift
//  Connect And Care
//
//  Created by Adrian Ziemecki on 29/03/16.
//  Copyright © 2016 Doro AB. All rights reserved.
//

import UIKit

let kFontSizeDefault: CGFloat = 20
let kVerticalPaddingDefault: CGFloat = 8
let kItemsHorizontalSpacingDefault: CGFloat = 0
let kCornerRadiusDefault: CGFloat = -1
let kBorderWidthDefault: CGFloat = 0
let kBorderColorDefault = UIColor.clearColor()

@IBDesignable
class DoroButton: UIButton {
    //var height: NSLayoutConstraint!
    let hiliteLayer: CALayer
    let disabledLayer: CALayer
    @IBInspectable var fontSize: CGFloat = kFontSizeDefault {
        didSet {
            titleLabel?.font = UIFont.boldSystemFontOfSize(fontSize)
        }
    }
    
    @IBInspectable var verticalPadding: CGFloat? {
        didSet {
            if let padding = verticalPadding {
                contentEdgeInsets.top += padding
                contentEdgeInsets.bottom += padding
            }
        }
    }
    
    @IBInspectable var itemsHorizontalSpacing: CGFloat = kItemsHorizontalSpacingDefault {
        didSet {
            if (self.imageView?.image == nil) {
                itemsHorizontalSpacing = 0
            }
            contentEdgeInsets.right += itemsHorizontalSpacing
            titleEdgeInsets.left += itemsHorizontalSpacing
            titleEdgeInsets.right += -itemsHorizontalSpacing
        }
    }
    
    //	@IBInspectable var cornerRadius: CGFloat = kCornerRadiusDefault {
    //		didSet {
    //			if cornerRadius >= 0 {
    //				layer.cornerRadius = cornerRadius
    //			} else {
    //				layer.cornerRadius = frame.height/2
    //			}
    //			layer.masksToBounds = true
    //		}
    //	}
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth/UIScreen.mainScreen().scale
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    override init(frame: CGRect) {
        hiliteLayer = CALayer()
        disabledLayer = CALayer()
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        hiliteLayer = CALayer()
        disabledLayer = CALayer()
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        titleLabel?.textAlignment = .Center
        
        if backgroundColor == nil {
            backgroundColor = UIColor.grayColor()
        }
        fontSize = kFontSizeDefault
        
        if verticalPadding == nil {
            verticalPadding = kVerticalPaddingDefault
        }
        
        configureHighliteLayer()
        configureDisabledLayer()
    }
    
    override func prepareForInterfaceBuilder() {
        setupViews()
    }
    
    override func drawRect(rect: CGRect) {
        roundCorners()
    }
    
    func roundCorners() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        
        titleLabel?.font = UIFont.boldSystemFontOfSize(fontSize)
        
    }
    
    private func configureHighliteLayer() {
        hiliteLayer.frame = layer.bounds
        hiliteLayer.opacity = 1
        hiliteLayer.backgroundColor = UIColor(white: 0.0, alpha: 0.2).CGColor
    }
    
    private func configureDisabledLayer() {
        disabledLayer.frame = layer.bounds
        disabledLayer.opacity = 1
        disabledLayer.backgroundColor = UIColor(white: 0.5, alpha: 0.5).CGColor
    }
    
    override var highlighted: Bool {
        set {
            if highlighted != newValue {
                super.highlighted = newValue
                if newValue {
                    layer.addSublayer(hiliteLayer)
                    let scale = CABasicAnimation(keyPath: "transform.scale")
                    scale.fromValue = 1
                    scale.toValue = 0.98
                    scale.duration = 0.1
                    scale.removedOnCompletion = false
                    scale.fillMode = kCAFillModeForwards
                    layer.addAnimation(scale, forKey: "scale")
                } else {
                    let scale = CABasicAnimation(keyPath: "transform.scale")
                    scale.fromValue = 0.98
                    scale.toValue = 1
                    scale.duration = 0.1
                    scale.removedOnCompletion = false
                    scale.fillMode = kCAFillModeForwards
                    layer.addAnimation(scale, forKey: "scale")
                    hiliteLayer.removeFromSuperlayer()
                }
            }
        }
        get {
            return super.highlighted
        }
    }
    
    override var enabled: Bool {
        set {
            if enabled != newValue {
                super.enabled = newValue
                if newValue {
                    disabledLayer.removeFromSuperlayer()
                } else {
                    layer.addSublayer(disabledLayer)
                }
            }
        }
        get {
            return super.enabled
        }
    }
}
