//
//  MDImageButton.swift
//  Mold
//
//  Created by Matt Quiros on 16/02/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

public class MDImageButton: MDButton {
    
    private let imageView = UIImageView(frame: CGRect.zero)
    
    public var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    public override var tintColor: UIColor! {
        get {
            return self.imageView.tintColor
        }
        set {
            self.imageView.tintColor = newValue
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviewsAndFill(self.imageView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviewsAndFill(self.imageView)
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        self.imageView.image = image
    }
    
}
