//
//  APCheckboxItem.swift
//  APCheckboxTree
//
//  Created by mac on 10.11.2021.
//

import UIKit

/// Checkbox item model
open class APCheckboxItem: CustomStringConvertible {
    
    // MARK: - Enum

    public enum ItemType {
        case group
        case single
    }

    public enum ItemSelectionState {
        case on
        case off
        case mixed
    }

    // MARK: - Public properties

    /// Title text
    public var title: String

    /// Subtitle text
    public var subtitle: String?

    /// Item type - single / group
    public var type: ItemType {
        return children.isEmpty ? .single : .group
    }

    /// Child items
    public var children: [APCheckboxItem] = []

    /// Is group collapsed (Applicable only to items with type *group*)
    public var isGroupCollapsed: Bool

    private var _isEnabled = true

    /// Is item available for selection
    public var isEnabled: Bool {
        get {
            return _isEnabled
        }
        set {
            _isEnabled = newValue

            for child in children {
                child.isEnabled = newValue
            }
        }
    }

    private var _isSelected: Bool

    /// Is item selected. (checkmark is ON if *true*)
    public var isSelected: Bool {
        get {
            if type == .group {
                return selectionState == .on
            } else {
                return _isSelected
            }
        }
        set {
            if isEnabled == false {
                return
            }

            _isSelected = newValue

            for child in children {
                child.isSelected = newValue
            }
        }
    }

    /// State of selection. Can be *mixed* for group item if it contains both selected and unselected items.
    public var selectionState: ItemSelectionState {
        if type == .group {

            if children.isEmpty {
                return .off
            }

            let hasMixedChild = children.contains{ $0.selectionState == .mixed }
            if hasMixedChild {
                return .mixed
            }

            let hasSelectedChild = children.contains{ $0.selectionState == .on }
            let hasUnselectedChild = children.contains{ $0.selectionState == .off }

            if hasSelectedChild && !hasUnselectedChild {
                return .on
            } else if !hasSelectedChild && hasUnselectedChild {
                return .off
            } else {
                return .mixed
            }
        }
        return isSelected ? .on : .off
    }

    // MARK: - Init
    
    /// Init node of checkbox tree
    /// - Parameters:
    ///   - title: Title
    ///   - subtitle: Subtitle
    ///   - children: Children of node
    ///   - isGroupCollapsed: children not visiable if *true*
    public convenience init(title: String, subtitle: String? = nil, children: [APCheckboxItem] = [], isGroupCollapsed: Bool = false) {
        self.init(title: title, subtitle: subtitle, isSelected: false, children: children, isGroupCollapsed: isGroupCollapsed)
    }
    
    /// Init leaf of checkbox tree
    /// - Parameters:
    ///   - title: Title
    ///   - subtitle: Subtitle
    ///   - isSelected: Checkbox selected or not
    public convenience init(title: String, subtitle: String? = nil, isSelected: Bool = false) {
        self.init(title: title, subtitle: subtitle, isSelected: isSelected, children: [], isGroupCollapsed: false)
    }

    /// Override purpose only. Call convinience init instead
    public init(title: String, subtitle: String? = nil, isSelected: Bool, children: [APCheckboxItem], isGroupCollapsed: Bool) {
        self.title = title
        self.subtitle = subtitle
        self._isSelected = isSelected
        self.children = children
        self.isGroupCollapsed = isGroupCollapsed
    }
    
    // MARK: - CustomStringConvertible
    
    open var description: String {
        var descriptionString = "title = \(title), state = \(selectionState)"
        if !isEnabled {
            descriptionString += ", isEnabled = false"
        }
        if !children.isEmpty {
            descriptionString += ", children = \(children.count)"
        }
        return "\(descriptionString)"
    }
}
