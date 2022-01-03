//
//  CheckboxTreeDelegate.swift
//  CheckboxTree
//
//  Created by mac on 03.01.2022.
//

import Foundation

public protocol CheckboxTreeDelegate: NSObject {
    /// Fires when checkbox item view tapped
    func checkboxTreeItemHasBeenTapped(item: CheckboxItem)
}
