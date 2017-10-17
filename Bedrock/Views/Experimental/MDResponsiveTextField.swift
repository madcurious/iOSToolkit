//
//  MDResponsiveTextField.swift
//  Mold
//
//  Created by Matt Quiros on 14/08/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

open class MDResponsiveTextField: UITextField {
    
    open var fontFace: String! {
        get {
            return self.font?.fontName
        }
        set {
            self.font = UIFont(name: newValue, size: self.font?.pointSize ?? UIFont.systemFontSize)
        }
    }
    
    open var fontSize: MDViewportBasedFontSize? {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    open override func layoutSubviews() {
        fatalError("Buggy implementation, super.layoutSubviews() causes infinite recursive call")
//        super.layoutSubviews()
//        
//        guard let fontSize = self.fontSize
//            else {
//                return
//        }
//        
//        let pointSize: CGFloat = {
//            switch fontSize {
//            case .vWidth(let ratio):
//                return self.bounds.size.width * ratio
//                
//            case .vHeight(let ratio):
//                return self.bounds.size.height * ratio
//                
//            case .vMin(let ratio):
//                return min(self.bounds.size.width, self.bounds.size.height) * ratio
//                
//            case .vMax(let ratio):
//                return max(self.bounds.size.width, self.bounds.size.height) * ratio
//            }
//        }()
//        
//        self.font = self.font?.withSize(pointSize)
    }
    
}
