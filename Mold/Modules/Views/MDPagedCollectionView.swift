//
//  MDPagedCollectionView.swift
//  Mold
//
//  Created by Matt Quiros on 02/06/2016.
//  Copyright © 2016 Matt Quiros. All rights reserved.
//

import UIKit

// MARK: - MDPagedCollectionViewDataSource
public protocol MDPagedCollectionViewDataSource {
    
    func numberOfItemsInCollectionView(collectionView: MDPagedCollectionView) -> Int
    func collectionView(collectionView: MDPagedCollectionView, cellForItemAtIndex index: Int) -> UICollectionViewCell
    
    
}

// MARK: - MDPagedCollectionViewDelegate
@objc public protocol MDPagedCollectionViewDelegate {
    
    // MARK: Layout
    func collectionView(collectionView: MDPagedCollectionView, sizeForItemAtIndex index: Int) -> CGSize
    func insetsForCollectionView(collectionView: MDPagedCollectionView) -> UIEdgeInsets
    func minimumInterItemSpacingForCollectionView(collectionView: MDPagedCollectionView) -> CGFloat
    
    // MARK: Events
//    optional func collectionView(collectionView: MDPagedCollectionView, didScrollToPage page: CGFloat)
    optional func collectionViewDidScroll(collectionView: MDPagedCollectionView, page: CGFloat)
    optional func collectionViewDidEndDecelerating(collectionView: MDPagedCollectionView, page: CGFloat)
    
}


// MARK: - MDPagedCollectionView
/**
 A paged collection view used primarily for partially showing the previous and next cells.
 */
public class MDPagedCollectionView: UIView {
    
    public let collectionView: UICollectionView
    public let scrollView: UIScrollView
    let layoutManager: UICollectionViewFlowLayout
    
    public var dataSource: MDPagedCollectionViewDataSource?
    public var delegate: MDPagedCollectionViewDelegate?
    
    public convenience init() {
        self.init(frame: CGRectZero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        // Instantiate.
        self.layoutManager = UICollectionViewFlowLayout()
        self.layoutManager.scrollDirection = .Horizontal
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.layoutManager)
        self.scrollView = UIScrollView()
        super.init(frame: frame)
        
        self.addSubviewsAndFill(self.scrollView, self.collectionView)
        UIView.clearBackgroundColors(self.collectionView, self.scrollView)
        
        // Setup.
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // From http://khanlou.com/2013/04/paging-a-overflowing-collection-view/
        // We have to transfer pan gesture recognition from the collection view to the hidden scroll view.
        self.collectionView.panGestureRecognizer.enabled = false
        self.collectionView.addGestureRecognizer(self.scrollView.panGestureRecognizer)
    }
    
    public func registerCellClass(cellClass: AnyClass, withReuseIdentifier identifier: String) {
        self.collectionView.registerClass(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func registerCellNib(nib: UINib, withReuseIdentifier identifier: String) {
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func reloadData() {
        guard let dataSource = self.dataSource
            else {
                return
        }
        
        self.collectionView.reloadData()
        
        // Remember the contentOffset.
        let offset = self.scrollView.contentSize.width - self.scrollView.contentOffset.x
        
        // Update the scroll view's content size--this is required to enable pagination.
        let width = self.scrollView.bounds.size.width * CGFloat(dataSource.numberOfItemsInCollectionView(self))
        self.scrollView.contentSize = CGSizeMake(width, self.scrollView.bounds.size.height)
        
        // Apply the old contentOffset.
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - offset, 0)
    }
    
    public func scrollToLastItem(animated animated: Bool, completion: (Void -> Void)?) {
        let numberOfItems = self.collectionView.numberOfItemsInSection(0)
        guard numberOfItems > 0
            else {
                return
        }
        
        let lastIndex = numberOfItems - 1
        self.scrollToItemAtIndex(lastIndex, animated: animated, completion: completion)
    }
    
    public func dequeueReusableCellWithReuseIdentifier(identifier: String, forIndex index: Int) -> UICollectionViewCell {
        return self.collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: NSIndexPath(forItem: index, inSection: 0))
    }
    
    public override func layoutSubviews() {
        self.layoutManager.invalidateLayout()
        super.layoutSubviews()
    }
    
    func scrollToItemAtIndex(index: Int, animated: Bool, completion: (Void -> Void)?) {
        // Scrolling to an index only means setting the contentOffset of the scrollView,
        // because doing so invokes scrollViewDidScroll, which already offsets the collection view correctly.
        
        let x = self.scrollView.bounds.size.width * CGFloat(index)
        if animated {
            UIView.animateWithDuration(0.25, animations: {[unowned self] in
                self.scrollView.contentOffset = CGPoint(x: x, y: self.scrollView.contentOffset.y)
                }, completion: { (_) in
                    completion?()
            })
        } else {
            self.scrollView.contentOffset = CGPoint(x: x, y: self.scrollView.contentOffset.y)
            completion?()
        }
    }
    
}

extension MDPagedCollectionView: UICollectionViewDataSource {
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.numberOfItemsInCollectionView(self)
        }
        return 0
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let dataSource = self.dataSource {
            return dataSource.collectionView(self, cellForItemAtIndex: indexPath.item)
        }
        fatalError("No cell found for MDPagedCollectionView: \(self)")
    }
    
}

extension MDPagedCollectionView: UICollectionViewDelegate {}

extension MDPagedCollectionView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if let delegate = self.delegate {
            return delegate.insetsForCollectionView(self)
        }
        return self.layoutManager.sectionInset
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let delegate = self.delegate {
            return delegate.collectionView(self, sizeForItemAtIndex: indexPath.item)
        }
        return self.layoutManager.itemSize
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if let delegate = self.delegate {
            return delegate.minimumInterItemSpacingForCollectionView(self)
        }
        return self.layoutManager.minimumLineSpacing
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        if let delegate = self.delegate {
            return delegate.minimumInterItemSpacingForCollectionView(self)
        }
        return self.layoutManager.minimumInteritemSpacing
    }
    
}

extension MDPagedCollectionView: UIScrollViewDelegate {
    
    // Translate the offset of the scrollView to the collectionView.
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let delegate = self.delegate
            where scrollView == self.scrollView // Do not recognize scrolls from the collection view.
            else {
                return
        }
        
        /*
         cv = collectionView
         sv = scrollView
         cv x = sv page * cell width
         sv page = sv X / page width
         */
        
        let page = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width
        let pageWidth = delegate.collectionView(self, sizeForItemAtIndex: 0).width + delegate.minimumInterItemSpacingForCollectionView(self)
        let cvX = page * pageWidth
        self.collectionView.contentOffset = CGPointMake(cvX, 0)
        
        delegate.collectionViewDidScroll?(self, page: page)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        guard let delegate = self.delegate
            where scrollView  == self.scrollView
            else {
                return
        }
        let page = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width
        delegate.collectionViewDidEndDecelerating?(self, page: page)
    }
    
}
