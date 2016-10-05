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
    
    func numberOfItemsInCollectionView(_ collectionView: MDPagedCollectionView) -> Int
    func collectionView(_ collectionView: MDPagedCollectionView, cellForItemAtIndex index: Int) -> UICollectionViewCell
    
    
}

// MARK: - MDPagedCollectionViewDelegate
@objc public protocol MDPagedCollectionViewDelegate {
    
    // MARK: Layout
    func collectionView(_ collectionView: MDPagedCollectionView, sizeForItemAtIndex index: Int) -> CGSize
    func insetsForCollectionView(_ collectionView: MDPagedCollectionView) -> UIEdgeInsets
    func minimumInterItemSpacingForCollectionView(_ collectionView: MDPagedCollectionView) -> CGFloat
    
    // MARK: Events
//    optional func collectionView(collectionView: MDPagedCollectionView, didScrollToPage page: CGFloat)
    @objc optional func collectionViewDidScroll(_ collectionView: MDPagedCollectionView, page: CGFloat)
    @objc optional func collectionViewDidEndDecelerating(_ collectionView: MDPagedCollectionView, page: CGFloat)
    
}


// MARK: - MDPagedCollectionView
/**
 A paged collection view used primarily for partially showing the previous and next cells.
 */
open class MDPagedCollectionView: UIView {
    
    open let collectionView: UICollectionView
    open let scrollView: UIScrollView
    let layoutManager: UICollectionViewFlowLayout
    
    open var dataSource: MDPagedCollectionViewDataSource?
    open var delegate: MDPagedCollectionViewDelegate?
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        // Instantiate.
        self.layoutManager = UICollectionViewFlowLayout()
        self.layoutManager.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layoutManager)
        self.scrollView = UIScrollView()
        super.init(frame: frame)
        
        self.addSubviewsAndFill(self.scrollView, self.collectionView)
        UIView.clearBackgroundColors(self.collectionView, self.scrollView)
        
        // Setup.
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // From http://khanlou.com/2013/04/paging-a-overflowing-collection-view/
        // We have to transfer pan gesture recognition from the collection view to the hidden scroll view.
        self.collectionView.panGestureRecognizer.isEnabled = false
        self.collectionView.addGestureRecognizer(self.scrollView.panGestureRecognizer)
    }
    
    open func registerCellClass(_ cellClass: AnyClass, withReuseIdentifier identifier: String) {
        self.collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func registerCellNib(_ nib: UINib, withReuseIdentifier identifier: String) {
        self.collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    open func reloadData() {
        guard let dataSource = self.dataSource
            else {
                return
        }
        
        self.collectionView.reloadData()
        
        // Remember the contentOffset.
        let offset = self.scrollView.contentSize.width - self.scrollView.contentOffset.x
        
        // Update the scroll view's content size--this is required to enable pagination.
        let width = self.scrollView.bounds.size.width * CGFloat(dataSource.numberOfItemsInCollectionView(self))
        self.scrollView.contentSize = CGSize(width: width, height: self.scrollView.bounds.size.height)
        
        // Apply the old contentOffset.
        self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentSize.width - offset, y: 0)
    }
    
    open func scrollToLastItem(animated: Bool, completion: ((Void) -> Void)?) {
        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        guard numberOfItems > 0
            else {
                return
        }
        
        let lastIndex = numberOfItems - 1
        self.scrollToItemAtIndex(lastIndex, animated: animated, completion: completion)
    }
    
    open func dequeueReusableCellWithReuseIdentifier(_ identifier: String, forIndex index: Int) -> UICollectionViewCell {
        return self.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(item: index, section: 0))
    }
    
    open override func layoutSubviews() {
        self.layoutManager.invalidateLayout()
        super.layoutSubviews()
    }
    
    func scrollToItemAtIndex(_ index: Int, animated: Bool, completion: ((Void) -> Void)?) {
        // Scrolling to an index only means setting the contentOffset of the scrollView,
        // because doing so invokes scrollViewDidScroll, which already offsets the collection view correctly.
        
        let x = self.scrollView.bounds.size.width * CGFloat(index)
        if animated {
            UIView.animate(withDuration: 0.25, animations: {[unowned self] in
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
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.numberOfItemsInCollectionView(self)
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dataSource = self.dataSource {
            return dataSource.collectionView(self, cellForItemAtIndex: (indexPath as NSIndexPath).item)
        }
        fatalError("No cell found for MDPagedCollectionView: \(self)")
    }
    
}

extension MDPagedCollectionView: UICollectionViewDelegate {}

extension MDPagedCollectionView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let delegate = self.delegate {
            return delegate.insetsForCollectionView(self)
        }
        return self.layoutManager.sectionInset
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let delegate = self.delegate {
            return delegate.collectionView(self, sizeForItemAtIndex: (indexPath as NSIndexPath).item)
        }
        return self.layoutManager.itemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let delegate = self.delegate {
            return delegate.minimumInterItemSpacingForCollectionView(self)
        }
        return self.layoutManager.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let delegate = self.delegate {
            return delegate.minimumInterItemSpacingForCollectionView(self)
        }
        return self.layoutManager.minimumInteritemSpacing
    }
    
}

extension MDPagedCollectionView: UIScrollViewDelegate {
    
    // Translate the offset of the scrollView to the collectionView.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let delegate = self.delegate
            , scrollView == self.scrollView // Do not recognize scrolls from the collection view.
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
        self.collectionView.contentOffset = CGPoint(x: cvX, y: 0)
        
        delegate.collectionViewDidScroll?(self, page: page)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let delegate = self.delegate
            , scrollView  == self.scrollView
            else {
                return
        }
        let page = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width
        delegate.collectionViewDidEndDecelerating?(self, page: page)
    }
    
}
