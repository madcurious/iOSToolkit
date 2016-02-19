//
//  MQImageButton.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 6/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import Foundation

public class MQImageButton: MQButton {
    
    public lazy var imageView = UIImageView()
    
    public override init() {
        super.init()
        self.customView.addSubviewAndFill(self.imageView)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}