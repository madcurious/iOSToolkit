//
//  MQPopupPickerViewController.swift
//  MQBoilerplateSwift
//
//  Created by Matt Quiros on 21/01/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

public protocol MQPopupPickerViewControllerDelegate {
    
    func popupPicker(picker: MQPopupPickerViewController, titleForChoiceAtIndex index: Int) -> String
    func popupPicker(picker: MQPopupPickerViewController, didPickValue value: AnyObject?, atIndex index: Int?, forField: MQField)
    
}

private let kPickerViewHeight = CGFloat(162)

public class MQPopupPickerViewController: UIViewController {
    
    var pickerView: UIPickerView
    
    public var field: MQField
    var choices: [AnyObject]
    var showsBlank: Bool
    var selectedRow: Int
    
    public var delegate: MQPopupPickerViewControllerDelegate?
    public var blankLabelText = "---"
    
    public init(field: MQField, choices: [AnyObject], showsBlank: Bool, initialIndex: Int?, sourceView: UIView) {
        self.pickerView = UIPickerView()
        
        self.field = field
        self.choices = choices
        self.showsBlank = showsBlank
        self.selectedRow = initialIndex ?? 0
        
        super.init(nibName: nil, bundle: nil)
        
        // Setup the popover configurations.
        self.modalPresentationStyle = .Popover
        self.preferredContentSize = CGSizeMake(320, kPickerViewHeight)
        if let popover = self.popoverPresentationController {
            popover.sourceView = sourceView
            popover.sourceRect = sourceView.bounds
            popover.delegate = self
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = UIView()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.pickerView.backgroundColor = UIColor.clearColor()
        
        self.view.addSubviews(self.pickerView)
        UIView.disableAutoresizingMasksInViews(self.pickerView)
        
        let rules = ["H:|-0-[pickerView]-0-|",
            "V:|-0-[pickerView(kPickerViewHeight)]-0-|"]
        let metrics = ["kPickerViewHeight" : kPickerViewHeight]
        let views = ["pickerView" : self.pickerView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormatArray(rules,
            metrics: metrics,
            views: views))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    
    func selectButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func indexOfChoiceAtRow(row: Int) -> Int? {
        if self.showsBlank {
            if row == 0 {
                return nil
            }
            return row - 1
        }
        return row
    }
    
}

extension MQPopupPickerViewController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .None
    }
    
}

extension MQPopupPickerViewController: UIPickerViewDataSource {
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.choices.count
    }
    
}

extension MQPopupPickerViewController: UIPickerViewDelegate {
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.showsBlank && row == 0 {
            return self.blankLabelText
        }
        
        if let delegate = self.delegate,
            let index = self.indexOfChoiceAtRow(row) {
                return delegate.popupPicker(self, titleForChoiceAtIndex: index)
        }
        
        return nil
    }
    
}
