//
//  MyItem.swift
//  CheckboxTree-Demo
//
//  Created by mac on 28.11.2022.
//

import APCheckboxTree

class MyItem: APCheckboxItem {
    
    public private(set) var emoji: String = ""
    
    convenience init(emoji: String, title: String, isSelected: Bool = false) {
        self.init(title: title, subtitle: nil, isSelected: isSelected, children: [], isGroupCollapsed: false)
        self.emoji = emoji
    }
    
    override init(title: String, subtitle: String? = nil, isSelected: Bool, children: [APCheckboxItem], isGroupCollapsed: Bool) {
        super.init(title: title, subtitle: subtitle, isSelected: isSelected, children: children, isGroupCollapsed: isGroupCollapsed)
    }
    
    // MARK: - Optional
    
    override var description: String {
        return "emoji = \(emoji), " + super.description
    }
}
