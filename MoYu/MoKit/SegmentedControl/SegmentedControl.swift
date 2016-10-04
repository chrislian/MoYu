//
//  SegmentedControl.swift
//  MoYu
//
//  Created by Chris on 2016/9/25.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit


@IBDesignable
open class SegmentedControl: UIControl {
    // Background
    @IBInspectable open
    var selectedBackgroundViewHeight: CGFloat = 0 { didSet { updateSelectedBackgroundFrame() } }
    
    @IBInspectable open
    var selectedBackgroundColor: UIColor = UIColor.darkGray { didSet { updateSelectedBackgroundColor() } }
    
    
    @IBInspectable open
    var titleFontSize:CGFloat = 15{
        didSet{
            updateTitleStyle()
        }
    }
    @IBInspectable open
    var titleColor: UIColor = UIColor.darkGray { didSet { updateTitleStyle() } }
    @IBInspectable open
    var highlightedTitleColor: UIColor = UIColor.yellow { didSet { updateTitleStyle() } }
    @IBInspectable open
    var selectedTitleColor: UIColor = UIColor.white { didSet { updateTitleStyle() } }
    
    // Segment
    @IBInspectable open
    var segmentTitles: String = "" { didSet { updateSegments(segmentTitles) } }
    open var segments: [SegmentTitleProvider] = ["Title 1", "Title 2"] { didSet { updateSegments(nil) } }
    open fileprivate(set) var segmentItems: [UIButton] = []
    
    // Selected
    @IBInspectable open var selectedIndex: Int = 0 {
        didSet {
            if selectedIndex < 0 {
                selectedIndex = 0
            }
            if selectedIndex > segments.count - 1 {
                selectedIndex = segments.count - 1
            }
            if selectedIndex < segmentItems.count {
                updateSelectedIndex(animationEnabled)
            }
        }
    }
    
    @IBInspectable open var animationEnabled: Bool = true
    
    open let selectedBackgroundView = UIView()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureElements()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureElements()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        updateSegmentFrames()
        updateSelectedIndex(false)
    }
    
    open func segmentTouched(_ sender: UIButton) {
        if let index = segmentItems.index(of: sender) {
            if(selectedIndex != index){
                selectedIndex = index
                sendActions(for: .touchUpInside)
            }
        }
    }
}

// MARK:- Private methods
private extension SegmentedControl {
    func configureElements() {
        let lineView = UIView(frame: CGRect(x: 0, y: 44, width: MoScreenWidth, height: 0.2))
        lineView.alpha = 0.3
        lineView.backgroundColor = UIColor.darkGray
        self.addSubview(lineView)
        
        insertSubview(selectedBackgroundView, at: 1)
        updateSegments(nil)
    }
    
    func updateSegments(_ titles: String?) {
        if let titles = titles {
            let extractedTitles = titles.characters.split(maxSplits: 100, omittingEmptySubsequences: true, whereSeparator: { $0 == "," }).map { String($0) }
            segments = extractedTitles.map({ $0 })
            return
        }
        
        // Clean up first
        for segmentItem in segmentItems {
            segmentItem.removeFromSuperview()
        }
        segmentItems.removeAll(keepingCapacity: true)
        
        // Reset data
        if segments.count > 0 {
            let itemWidth: CGFloat = frame.width / CGFloat(segments.count)
            for (index, segment) in segments.enumerated() {
                let item = UIButton(frame: CGRect(
                    x: itemWidth * CGFloat(index),
                    y: 0,
                    width: itemWidth,
                    height: frame.height
                    ))
                
                item.isSelected = (index == selectedIndex)
                item.setTitle(segment.segmentTitle(), for: UIControlState())
                item.addTarget(self, action: #selector(SegmentedControl.segmentTouched(_:)), for: UIControlEvents.touchUpInside)
                
                addSubview(item)
                segmentItems.append(item)
            }
        }
        
        updateTitleStyle()
        updateSelectedIndex(false)
    }
    
    func updateSegmentFrames() {
        if segments.count > 0 {
            let itemWidth: CGFloat = frame.width / CGFloat(segmentItems.count)
            for (index, item) in segmentItems.enumerated() {
                item.frame = CGRect(
                    x: itemWidth * CGFloat(index),
                    y: 0,
                    width: itemWidth,
                    height: frame.height
                )
            }
        }
    }
    
    func updateTitleStyle() {
        for item in segmentItems {
            item.setTitleColor(titleColor, for: UIControlState())
            item.setTitleColor(highlightedTitleColor, for: .highlighted)
            item.setTitleColor(selectedTitleColor, for: .selected)
            item.titleLabel?.font = UIFont.mo_font()
        }
    }
    
    func updateSelectedIndex(_ animated: Bool) {
        for item in segmentItems {
            item.isSelected = false
        }
        if animated {
            UIView.animate(withDuration: 0.3,
                                       delay: 0,
                                       usingSpringWithDamping: 0.7,
                                       initialSpringVelocity: 0.3,
                                       options: UIViewAnimationOptions.curveEaseOut,
                                       animations: {
                                        self.updateSelectedBackgroundFrame()
                }, completion: { finished in
                    self.segmentItems[self.selectedIndex].isSelected = true
                    
            })
        } else {
            updateSelectedBackgroundFrame()
            segmentItems[selectedIndex].isSelected = true
        }
    }
    
    func updateSelectedBackgroundColor() {
        selectedBackgroundView.backgroundColor = selectedBackgroundColor
    }
    
    func updateSelectedBackgroundFrame() {
        if selectedIndex < segmentItems.count {
            let segment = segmentItems[selectedIndex]
            //            print(segment.titleLabel?.frame)
            var frame = segment.frame
            frame.size.height = selectedBackgroundViewHeight > 0 ? selectedBackgroundViewHeight : self.frame.height
            frame.origin.y = selectedBackgroundViewHeight > 0 ? self.frame.height - selectedBackgroundViewHeight : 0
            
            selectedBackgroundView.frame = frame
        }
    }
}

// MARK:- Data types, Protocol & Extensions
public protocol SegmentTitleProvider {
    func segmentTitle() -> String
}

extension String: SegmentTitleProvider {
    public func segmentTitle() -> String {
        return self
    }
}

extension UIViewController: SegmentTitleProvider {
    public func segmentTitle() -> String {
        return title ?? ""
    }
}
