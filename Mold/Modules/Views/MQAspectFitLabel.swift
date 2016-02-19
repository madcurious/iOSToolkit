//
//  MQAspectFitLabel.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 5/29/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

private let CGSizeMax = CGSizeMake(CGFloat.max, CGFloat.max)

/**
A subclass of `UILabel` that automatically adjusts the text's font size
so that the text fits exactly within the bounds of the label.
*/
public class MQAspectFitLabel: UILabel {
    
    private enum ScaleDirection {
        case Grow, Shrink, None
        
        func opposite() -> ScaleDirection {
            switch self {
            case .Grow:
                return .Shrink
                
            case .Shrink:
                return .Grow
                
            case .None:
                return .None
            }
        }
    }
    
    public init() {
        super.init(frame: CGRectZero)
        self.setTextAlignment()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTextAlignment()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTextAlignment()
    }
    
    func setTextAlignment() {
        self.textAlignment = .Center
    }
    
    public func setFontSize(fontSize: CGFloat) {
        self.font = UIFont(name: self.font.fontName, size: fontSize)
    }
    
    /**
    Finds the font size to apply to the entire string so that the text's intrinsic size
    can be scaled up or down to fit inside the label's dimensions.
    
    **Important** This function only works for labels where all the string characters
    are the same font size. This will not work properly on attributed strings that have
    different font sizes in certain parts of the string.
    */
    public func adjustFontSizeToScaleAspectFit() {
        if let _: NSString = self.text {
            // Find the min and max font sizes before doing a binary search.
            var currentSize = self.self.font.pointSize > 0 ? self.self.font.pointSize : UIFont.systemFontSize()
            var min = CGFloat(0)
            var max = CGFloat(0)
            
            let startingDirection = self.scaleDirectionForFontSize(currentSize)
            var currentDirection = startingDirection
            
            loop: while true {
                switch currentDirection {
                case .None:
                    // The correct font size was suddenly found, so set it already
                    // and leave the function.
                    self.setFontSize(currentSize)
                    return
                    
                default:
                    if currentDirection == startingDirection.opposite() {
                        if startingDirection == .Grow {
                            max = currentSize
                            min = max / 2
                        } else if startingDirection == .Shrink {
                            min = currentSize
                            max = min * 2
                        }
                        break loop
                    } else if currentDirection == .Grow {
                        currentSize *= 2
                    } else if currentDirection == .Shrink {
                        currentSize /= 2
                    }
                }
                
                currentDirection = self.scaleDirectionForFontSize(currentSize)
            }
            
            
            var mid: CGFloat
            
            loop: while true {
                mid = min + ((max - min) / 2)
                
                switch self.scaleDirectionForFontSize(mid) {
                case .Grow:
                    min = mid
                    
                case .Shrink:
                    max = mid
                    
                case .None:
                    self.setFontSize(mid)
                    return
                }
            }
        }
    }
    
    private func scaleDirectionForFontSize(fontSize: CGFloat) -> ScaleDirection {
        if let text = self.text {
            let textSize = text.boundingRectWithSize(CGSizeMax,
                options: [.UsesLineFragmentOrigin, .UsesFontLeading],
                attributes: [NSFontAttributeName : UIFont(name: self.font.fontName, size: fontSize)!],
                context: nil).size
            
            let labelWidth = floor(self.bounds.size.width)
            let labelHeight = floor(self.bounds.size.height)
            let textWidth = ceil(textSize.width)
            let textHeight = ceil(textSize.height)
            
            if labelWidth > textWidth && labelHeight > textHeight {
                return .Grow
            } else if labelWidth < textWidth || labelHeight < textHeight {
                return .Shrink
            }
        }
        
        return .None
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.adjustFontSizeToScaleAspectFit()
    }
    
}