//
//  CheckboxItemDelegate.swift
//  APCheckboxList
//
//  Created by mac on 03.01.2022.
//

import Foundation

protocol CheckboxItemDelegate: NSObject {
    func checkboxItemDidSelected(item: APCheckboxItem)
}
