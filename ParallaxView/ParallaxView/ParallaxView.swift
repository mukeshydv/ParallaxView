//
//  ParallaxView.swift
//  ParallaxView
//
//  Created by Mukesh on 24/10/18.
//  Copyright © 2018 BooEat. All rights reserved.
//

import UIKit

class ParallaxView: UIView {
    var heightLayoutConstraint: NSLayoutConstraint!
    var bottomLayoutConstraint: NSLayoutConstraint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, image: UIImage, title: String) {
        let parallexView = UINib(nibName: "ParallaxContainerView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ParallaxContainerView
        
        parallexView.imageView.image = image
        parallexView.titleLabel.text = title
        
        self.init(frame: frame, view: parallexView, bottomStreachingView: parallexView.imageView)
    }
    
    init(frame: CGRect, view: UIView, bottomStreachingView: UIView?) {
        super.init(frame: frame)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        view.frame = frame
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view" : view]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[view]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view" : view]))
        
        bottomLayoutConstraint = bottomStreachingView?.bottomAnchor.constraint(equalTo: bottomAnchor)
        heightLayoutConstraint = view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1)
        heightLayoutConstraint.isActive = true
        bottomLayoutConstraint?.isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        clipsToBounds = offsetY <= 0
        bottomLayoutConstraint?.constant = offsetY >= 0 ? 0 : -offsetY
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}

extension ParallaxView {
    
    /// Use this method to add a simple Parallax View with a `Label` and `UIImageView`.
    ///
    /// - Parameters:
    ///   - tableView: `UITableView` on which you want to add the Parallax View
    ///   - image: `UIImage` to add to the view.
    ///   - title: `String` to add to label.
    ///   - height: Height of the Parallax view
    static func add(to tableView: UITableView, image: UIImage, title: String, height: CGFloat = 260) {
        let view = ParallaxView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: height), image: image, title: title)
        tableView.tableHeaderView = view
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    /// Use this method to add a custom view in your tableview header
    ///
    /// - Parameters:
    ///   - tableView: `UITableView` on which you want to add the Parallax View
    ///   - view: Custom view which you want to add
    ///   - bottomStreachingView: This is the view which will shrink when you scroll upside, If you dont want other parts to shrink during upside scroll don't add their constraint with this view.
    ///   - height: Height of the Parallax view
    static func add(to tableView: UITableView, view: UIView, bottomStreachingView: UIView? = nil, height: CGFloat = 260) {
        let view = ParallaxView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: height), view: view, bottomStreachingView: bottomStreachingView)
        tableView.tableHeaderView = view
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
}
