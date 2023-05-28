//
//  NibDesignable.swift
//  CAFU
//
//  Created by Ahmed Ramy on 21/09/2022.
//

import Combine
import UIKit

// MARK: - NibDesignable

@IBDesignable
open class NibDesignable: UIView {
    public var cancellables: Set<AnyCancellable> = .init()
    public var nibContainerView: UIView {
        self
    }

    open var bundle: Bundle { .main }

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }

    // MARK: - NSCoding
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }

    /// Called in the default implementation of loadNib(). Default is class name.
    ///
    /// - returns: Name of a single view nib file.
    open func nibName() -> String {
        type(of: self).description().components(separatedBy: ".").last!
    }

    /// Called to load the nib in setupNib().
    ///
    /// - returns: UIView instance loaded from a nib file.
    public func loadNib() -> UIView {
        let nib = UINib(nibName: nibName(), bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return UIView()
        }

        view.accessibilityLabel = nibName()
        return view
    }

    // MARK: - Nib loading

    /// Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
    fileprivate func setupNib() {
        let view = loadNib()
        nibContainerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        nibContainerView
            .addConstraints(
                NSLayoutConstraint
                    .constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        nibContainerView
            .addConstraints(
                NSLayoutConstraint
                    .constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
    }
}
