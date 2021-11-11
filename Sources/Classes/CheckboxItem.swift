//
//  CheckboxItem.swift
//  CheckboxList
//
//  Created by mac on 10.11.2021.
//

import Foundation
import UIKit

public class CheckboxItem {

    // MARK: - Enum

    public enum ItemType {
        case group
        case single
    }

    // MARK: - Public properties

    /// Заголовок
    public var title: String

    /// Подзаголовок
    public var subtitle: String?

    /// Тип элемента (Группа или единичный)
    public var type: ItemType {
        return children.isEmpty ? .single : .group
    }

    /// Элементы внутри группы
    public var children: [CheckboxItem] = []

    public var groupCollapsed: Bool

    private var _isSelected: Bool

    /// Доступен ли элемент для выбора
    public var isSelected: Bool {
        get {
            if type == .group {
                return !children.contains{ !$0.isSelected }
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

    /// Состояние выбора
    public var selectionState: ItemState {
        if type == .group {
            let hasSelectedChild = children.contains{ $0.isSelected }
            let hasUnselectedChild = children.contains{ !$0.isSelected }

            if hasSelectedChild && !hasUnselectedChild {
                return .on
            } else if !hasSelectedChild && hasUnselectedChild {
                return .off
            } else if hasSelectedChild && hasUnselectedChild {
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
        self.groupCollapsed = groupCollapsed
    }
}

extension CheckboxItem {
    public enum ItemState {
        case on
        case off
        case mixed

        func image() -> UIImage? {
            switch self {
            case .on:
                return CheckboxImageProvider.checkboxOn()
            case .off:
                return CheckboxImageProvider.checkboxOff()
            case .mixed:
                return CheckboxImageProvider.checkboxMixed()
            }
        }
    }
}
