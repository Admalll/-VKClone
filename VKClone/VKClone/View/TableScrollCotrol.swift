// TableScrollCotrol.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class TableScrollCotrol: UIControl {
    enum Const {
        static let verticalSpacing: CGFloat = 4
    }

    // MARK: - Visual components

    private var letterLabelsCollection: [UILabel] = []
    private var letterLabelsStackView = UIStackView()

    // MARK: - Private properties

    private(set) var selectedIndex: Int?
    private var letters: [Character] = []

    // MARK: - UIControl

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: letterLabelsStackView)
        handleTouch(at: location)
        return super.beginTracking(touch, with: event)
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        selectedIndex = nil
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: letterLabelsStackView)
        handleTouch(at: location)
        return super.continueTracking(touch, with: event)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupStackViewHeight()
    }

    // MARK: - Initializators

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabelsStackView()
        setupTapGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabelsStackView()
        setupTapGestureRecognizer()
    }

    // MARK: - Public methods

    func setupLetters(letters: [Character]) {
        self.letters = letters
        setupLetterLabels()
        setupLetterLabelsViews()
        setupStackViewHeight()
    }

    // MARK: - Private methods

    private func setupLetterLabels() {
        letterLabelsCollection = []

        for letter in letters {
            let label = UILabel()
            label.text = String(letter)
            label.textColor = .systemBlue
            label.isUserInteractionEnabled = false
            label.textAlignment = .right
            label.font = UIFont.systemFont(ofSize: 10)
            letterLabelsCollection += [label]
        }
    }

    private func setupLabelsStackView() {
        letterLabelsStackView.axis = .vertical
        letterLabelsStackView.distribution = .fillEqually
        letterLabelsStackView.spacing = Const.verticalSpacing
        letterLabelsStackView.isUserInteractionEnabled = false
        addSubview(letterLabelsStackView)
    }

    private func setupLetterLabelsViews() {
        letterLabelsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        letterLabelsCollection.forEach {
            letterLabelsStackView.addArrangedSubview($0)
        }
    }

    private func setupStackViewHeight() {
        var height = CGFloat()
        letterLabelsCollection.forEach {
            letterLabelsStackView.addArrangedSubview($0)
            height += $0.intrinsicContentSize.height
        }
        height += CGFloat(letterLabelsCollection.count - 1) * Const.verticalSpacing
        letterLabelsStackView.frame = CGRect(x: 0, y: (bounds.height - height) / 2, width: bounds.width, height: height)
    }

    private func handleTouch(at location: CGPoint) {
        for (index, label) in letterLabelsCollection.enumerated() {
            if label.frame.contains(location) {
                if selectedIndex != index {
                    selectedIndex = index
                    sendActions(for: .valueChanged)
                }
                break
            }
        }
    }

    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onControlTap(sender:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func onControlTap(sender: UITapGestureRecognizer) {
        handleTouch(at: sender.location(in: letterLabelsStackView))
        selectedIndex = nil
    }
}
