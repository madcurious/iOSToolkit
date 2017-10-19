//
//  BRListItemView.swift
//  iOSCodingTask_MattQuiros
//
//  Created by Matt Quiros on 17/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

@IBDesignable
public class BRListItemView: UIView {
    
    @IBOutlet public weak var contentStackView: UIStackView!
    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var textLabel: UILabel!
    
    fileprivate let queue = OperationQueue()
    fileprivate var currentUrlString: String?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    fileprivate func setup() {
        let viewFromNib = viewFromOwnedNib()
        addSubviewsAndFill(viewFromNib)
        
        imageView.contentMode = .scaleAspectFit
        
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
    }
    
    public func loadImage(from urlString: String) {
        guard currentUrlString != urlString
            else {
                return
        }
        
        queue.cancelAllOperations()
        currentUrlString = urlString
        
        let imageRequest = BRHttpImageRequest(urlString: urlString) { [weak self] (someResult) in
            guard let weakSelf = self,
                let result = someResult
                else {
                    return
            }
            if case .success(let image) = result,
                weakSelf.currentUrlString == urlString {
                DispatchQueue.main.async {
                    weakSelf.imageView.image = image
                }
            }
        }
        
        queue.addOperation(imageRequest)
    }
    
}
