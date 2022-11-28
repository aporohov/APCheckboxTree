//
//  APCheckboxTree.swift
//  APCheckboxTree
//
//  Created by mac on 09.11.2021.
//

import UIKit

open class APCheckboxTree<T: APCheckboxItem>: UIView {
    
    // MARK: - Public properties

    /// Checkbox items
    public var items: [T] = [] {
        didSet {
            reload()
        }
    }

    /// Customizable style of tree
    public private(set) var style: APCheckboxTreeStyle<T> = APCheckboxTreeStyle()

    /// Checkbox tree delegate
    public weak var delegate: APCheckboxTreeDelegate?

    // MARK: - Private properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private var nodes: [CheckboxNode<T>] = []

    // MARK: - Init

    public init(style: APCheckboxTreeStyle<T> = APCheckboxTreeStyle()) {
        self.style = style
        super.init(frame: .zero)
        setupView()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    /// Reload checkbox tree
    open func reload() {
        stackView.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }

        nodes.removeAll()

        checkIfCollapseAvailable()
        
        buildCheckboxTree()
    }

    // MARK: - Private methods

    private func setupView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func buildCheckboxTree() {
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
    
    private func checkIfCollapseAvailable() {
        if !items.contains(where: { $0.type == .group }) {
            style.isCollapseAvailable = false
        }
    }
}

extension APCheckboxTree: CheckboxItemDelegate {
    func checkboxItemDidSelected(item: APCheckboxItem) {
        delegate?.checkboxItemDidSelected(item: item)
    }
}
