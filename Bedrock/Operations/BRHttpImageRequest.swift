//
//  BRHttpImageRequest.swift
//  iOSCodingTask_MattQuiros
//
//  Created by Matt Quiros on 17/10/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

public enum BRHttpImageRequestError: LocalizedError {
    case invalidImageData
    case noImageDataFound
    case responseError(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidImageData:
            return "Image data is invalid"
        case .noImageDataFound:
            return "No image data found"
        case .responseError(let error):
            return error.localizedDescription
        }
    }
}

fileprivate let kSharedSession = URLSession(configuration: .default)

public class BRHttpImageRequest: BRAsynchronousOperation<UIImage, BRHttpImageRequestError> {
    
    let urlString: String
    var downloadTask: URLSessionTask?
    
    public init(urlString: String, completionBlock: BROperationCompletionBlock?) {
        self.urlString = urlString
        super.init(completionBlock: completionBlock)
    }
    
    public override func main() {
        guard let url = URL(string: urlString)
            else {
                finish()
                return
        }
        
        let task = kSharedSession.dataTask(with: url) { (someData, someResponse, someError) in
            defer {
                self.finish()
            }
            
            if self.isCancelled {
                return
            }
            
            if let error = someError {
                self.result = .error(.responseError(error))
                return
            }
            
            guard let data = someData
                else {
                    self.result = .error(.noImageDataFound)
                    return
            }
            
            guard let image = UIImage(data: data)
                else {
                    self.result = .error(.invalidImageData)
                    return
            }
            
            self.result = .success(image)
        }
        
        task.resume()
        downloadTask = task
    }
    
}

