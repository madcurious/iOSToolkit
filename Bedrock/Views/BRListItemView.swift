//
//  BRListItemView.swift
//  iOSCodingTask_MattQuiros
//
//  Created by Matt Quiros on 17/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

@IBDesignable
class BRListItemView: UIView {
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    fileprivate let queue = OperationQueue()
    fileprivate var currentUrlString: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
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
    
    func fetchImage(from urlString: String) {
        guard currentUrlString != urlString
            else {
                return
        }
        
        queue.cancelAllOperations()
        currentUrlString = urlString
        
        let fetchOperation = BRHttpImageRequest(urlString: urlString) { [weak self] (result) in
            guard let weakSelf = self
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
        
        queue.addOperation(fetchOperation)
    }
    
}
