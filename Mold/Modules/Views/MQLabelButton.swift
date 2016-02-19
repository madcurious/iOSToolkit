//
//  MQLabelButton.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 6/8/15.
//  Copyright (c) 2015 Matt Quiros. All rights reserved.
//

import UIKit

public class MQLabelButton: MQButton {
    
    public var label: UILabel = UILabel()
    
    public override init() {
        super.init()
        self.label.textAlignment = .Center
        self.customView.addSubviewAndFill(self.label)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sizeToFit() {
        self.label.sizeToFit()
        self.bounds = self.label.bounds
    }
    
}