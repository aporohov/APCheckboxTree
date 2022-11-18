//
//  APCheckboxListDelegate.swift
//  APCheckboxList
//
//  Created by mac on 03.01.2022.
//

import Foundation

public protocol APCheckboxListDelegate: NSObject {
    /// Fires when checkbox item view tapped
    func checkboxListItemDidSelected(item: APCheckboxItem)
}
