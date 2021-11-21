//
//  CheckboxImageProvider.swift
//  CheckboxList
//
//  Created by mac on 14.11.2021.
//

import UIKit

public class CheckboxImageProvider {

    public static var bundle: Bundle?

    public static func groupArrow() -> UIImage? {
        return CheckboxImageProvider.image(named: "icGroupArrow")
    }

    public static func checkboxOn() -> UIImage? {
        return CheckboxImageProvider.image(named: "icCheckboxOn")
    }

    public static func checkboxOff() -> UIImage? {
        return CheckboxImageProvider.image(named: "icCheckboxOff")
    }

    public static func checkboxMixed() -> UIImage? {
        return CheckboxImageProvider.image(named: "icCheckboxMixed")
    }

    static func image(named: String) -> UIImage? {

        let bundle = CheckboxImageProvider.bundle ?? Bundle(for: self)

        let im = UIImage(named: named, in: bundle, compatibleWith: nil)

        return im
    }
}
