//
//  APCheckboxTreeDelegate.swift
//  APCheckboxTree
//
//  Created by mac on 03.01.2022.
//

import Foundation

public protocol APCheckboxTreeDelegate: NSObject {
    /// Fires when checkbox item view tapped
    func checkboxItemDidSelected(item: APCheckboxItem)
}
