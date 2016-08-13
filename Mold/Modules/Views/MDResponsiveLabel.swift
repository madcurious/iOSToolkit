//
//  MDResponsiveLabel.swift
//  Mold
//
//  Created by Matt Quiros on 13/08/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public class MDResponsiveLabel: UILabel {
    
    public var fontFace: String! {
        get {
            return self.font.fontName
        }
        set {
            self.font = UIFont(name: newValue, size: self.font.pointSize)
        }
    }
    
    public var fontSize: MDViewportBasedFontSize? {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let fontSize = self.fontSize
            else {
                return
        }
        
        let pointSize: CGFloat = {
            switch fontSize {
            case .VWidth(let ratio):
                return self.bounds.size.width * ratio
                
            case .VHeight(let ratio):
                return self.bounds.size.height * ratio
                
            case .VMin(let ratio):
                return min(self.bounds.size.width, self.bounds.size.height) * ratio
                
            case .VMax(let ratio):
                return max(self.bounds.size.width, self.bounds.size.height) * ratio
            }
        }()
        
        self.font = self.font.fontWithSize(pointSize)
    }
    
}