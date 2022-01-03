//
//  CheckboxTree.swift
//  CheckboxTree
//
//  Created by mac on 09.11.2021.
//

import UIKit

open class CheckboxTree: UIView {

    // MARK: - Public properties

    /// Checkbox items
    public var items: [CheckboxItem] = [] {
        didSet {
            reloadTree()
        }
    }

    /// Customizable style of tree
    public var style = CheckboxTreeStyle()

    /// Tree delegate
    public weak var delegate: CheckboxTreeDelegate?

    // MARK: - Private properties

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    var nodes: [CheckboxNode] = []

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    /// Reload checkbox tree
    public func reloadTree() {
        stackView.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }

        nodes.removeAll()

        buildCheckboxTree()
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

    func buildCheckboxTree() {
        for item in items {
            let node = CheckboxNode(item: item,
                                    depth: 0,
                                    parentNode: nil,
                                    style: style,
                                    delegate: self)
            nodes.append(node)

            node.forEachBranchNode { childNode in
                stackView.addArrangedSubview(childNode.itemView)

                childNode.updateItemViewVisibility()
            }
        }
    }
}

extension CheckboxTree: CheckboxItemDelegate {
    func checkboxItemHasBeenTapped(item: CheckboxItem) {
        delegate?.checkboxTreeItemHasBeenTapped(item: item)
    }
}
