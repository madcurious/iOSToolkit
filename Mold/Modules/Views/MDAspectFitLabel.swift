//
//  MQAspectFitLabel.swift
//  Mold
//
//  Created by Matt Quiros on 5/29/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

/**
A subclass of `UILabel` that automatically adjusts the text's font size
so that the text fits exactly within the bounds of the label.
*/

public class MDAspectFitLabel: UILabel {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.scaleFontSize()
    }
    
    func scaleFontSize() {
        guard let text = self.text,
            let font = self.font
            else {
                return
        }
        
        // Get the label's dimensions.
        let labelWidth = floor(self.bounds.size.width)
        let labelHeight = floor(self.bounds.size.height)
        
        // Get the text string's dimensions.
        var textSize = self.sizeOfText(text, atFontSize: self.font.pointSize)
        var textWidth = ceil(textSize.width)
        var textHeight = ceil(textSize.height)
        
        var min = CGFloat(0)
        var max = CGFloat(500) // Magic number is just an assumed maximum.
        var mid = self.font.pointSize
        
        // Keep scaling until either the text width or height is equal to the label width or height, respectively,
        // with the other dimension being less than or equal the corresponding dimension.
        while ((labelWidth == textWidth && textHeight <= labelHeight) ||
            (labelHeight == textHeight && textWidth <= labelWidth)) == false {
                
                // If the label is greater than the text, grow the font size.
                if labelWidth > textWidth && labelHeight > textHeight {
                    min = mid
                } else {
                    max = mid
                }
                
                mid = min + ((max - min) / 2)
                textSize = self.sizeOfText(text, atFontSize: mid)
                textWidth = ceil(textSize.width)
                textHeight = ceil(textSize.height)
        }
        
        self.font = UIFont(name: font.fontName, size: mid)
    }
    
    func sizeOfText(text: String, atFontSize fontSize: CGFloat) -> CGSize {
        let size = text.boundingRectWithSize(CGSizeMax,
                                             options: [.UsesLineFragmentOrigin, .UsesFontLeading],
                                             attributes: [NSFontAttributeName : UIFont(name: self.font.fontName, size: fontSize)!],
                                             context: nil).size
        return size
    }
    
}
