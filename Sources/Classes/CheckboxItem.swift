//
//  CheckboxItem.swift
//  CheckboxTree
//
//  Created by mac on 10.11.2021.
//

import UIKit

/// Checkbox item model
public class CheckboxItem {

    // MARK: - Enum

    public enum ItemType {
        case group
        case single
    }

    public enum ItemState {
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
    public var children: [CheckboxItem] = []

    /// Is group collapsed. (Applicable only to items with type *group*)
    public var isGroupCollapsed: Bool

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
            _isSelected = newValue

            for child in children {
                child.isSelected = newValue
            }
        }
    }

    /// State of selection. Can be *mixed* for group item if it contains both selected and unselected.
    public var selectionState: ItemState {
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

    public convenience init(title: String, subtitle: String? = nil, children: [CheckboxItem] = [], groupCollapsed: Bool = false) {
        self.init(title: title, subtitle: subtitle, isSelected: false, children: children, groupCollapsed: groupCollapsed)
    }

    public convenience init(title: String, subtitle: String? = nil, isSelected: Bool) {
        self.init(title: title, subtitle: subtitle, isSelected: isSelected, children: [], groupCollapsed: false)
    }

    init(title: String, subtitle: String? = nil, isSelected: Bool, children: [CheckboxItem], groupCollapsed: Bool) {
        self.title = title
        self.subtitle = subtitle
        self._isSelected = isSelected
        self.children = children
        self.isGroupCollapsed = groupCollapsed
    }
}
