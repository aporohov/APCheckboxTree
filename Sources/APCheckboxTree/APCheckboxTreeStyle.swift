//
//  APCheckboxTreeStyle.swift
//  APCheckboxTree
//
//  Created by mac on 21.11.2021.
//

import UIKit

/// Describes checkbox tree display style
open class APCheckboxTreeStyle<T: APCheckboxItem> {
    
    public struct Images {
        public var checkboxOn: UIImage?
        public var checkboxOff: UIImage?
        public var checkboxMixed: UIImage?
        public var groupArrow: UIImage?
    }

    public struct ItemViewStyle {
        public var levelBoxSize: CGSize = .init(width: 24, height: 24)
        public var elementsSpacing: CGFloat = 8
        public var minHeight: CGFloat = 44
        public var titleFont: UIFont = .systemFont(ofSize: 17, weight: .regular)
        public var subtitleFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
        public var titleColor: UIColor = .label
        public var subtitleColor: UIColor = .secondaryLabel
        public var disabledStateColor: UIColor = .tertiaryLabel
    }

    // MARK: - Properties
    
    /// Items group collapse availability. If *false*, then item view arrow will not be shown.
    public var isCollapseAvailable: Bool = true

    /// Should items group collapse animation be shown
    public var isCollapseAnimated: Bool = true

    /// Items group collapse animation duration
    public var collapseAnimationDuration: TimeInterval = 0.2

    /// Describes single item view style
    public var itemViewStyle = ItemViewStyle()

    /// Contains all checkbox state images
    public var images = Images()

    // MARK: - Open methods
    
    /// Checkbox item view. Must be subclass of *APCheckboxItemView*. Overridable.
    open func getCheckboxItemView() -> APCheckboxItemView<T> {
        return APCheckboxItemView(style: self)
    }
    
    // MARK: - Init
    
    public init() {
        setupDefaultImages()
    }

    // MARK: - Private methods
    
    func setupDefaultImages() {
#if SWIFT_PACKAGE
        let bundle = Bundle.module
#else
        
#endif
        
        images.checkboxOn = UIImage(named: "icCheckboxOn", in: bundle, compatibleWith: nil)
        images.checkboxOff = UIImage(named: "icCheckboxOff", in: bundle, compatibleWith: nil)
        images.checkboxMixed = UIImage(named: "icCheckboxMixed", in: bundle, compatibleWith: nil)
        images.groupArrow = UIImage(named: "icGroupArrow", in: bundle, compatibleWith: nil)
    }
}
