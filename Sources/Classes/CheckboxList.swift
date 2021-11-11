//
//  CheckboxList.swift
//  CheckboxList
//
//  Created by mac on 09.11.2021.
//

import UIKit

public class CheckboxList: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    /// Элементы списка
    public var items: [CheckboxItem] = [] {
        didSet {
            setupStackView()
        }
    }

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    func setupView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupStackView() {
        stackView.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }
        arrangeItems(items, level: 0)
    }

    @discardableResult
    func arrangeItems(_ items: [CheckboxItem], level: Int) -> [CheckboxItemView] {
        var itemViews: [CheckboxItemView] = []

        for item in items {

//            item.delegate = self

            let itemOffset = CGFloat(15 * level)//Constants.levelOffset * CGFloat(min(level, 3))

            let itemView = CheckboxItemView()
            itemView.setupView(item: item, leftOffset: itemOffset)
            itemViews.append(itemView)

            itemView.tapAction = { [weak self] in
                item.isSelected.toggle()
                self?.setupStackView()
            }

            stackView.addArrangedSubview(itemView)

            let groupItemViews = arrangeItems(item.children, level: level + 1)

            for groupItemView in groupItemViews {
                groupItemView.isHidden = item.groupCollapsed
            }

            itemView.collapseAction = { //[weak self] in
                item.groupCollapsed.toggle()
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                    for groupItemView in groupItemViews {
                        groupItemView.isHidden = item.groupCollapsed
                    }
//                    self.stackView.layoutIfNeeded()
                }
            }
        }

        return itemViews
    }
}

public class CheckboxImageProvider {

    public static var bundle: Bundle?

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
