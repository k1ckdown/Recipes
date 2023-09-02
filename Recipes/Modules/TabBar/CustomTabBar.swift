//
//  CustomTabBar.swift
//  Recipes
//
//  Created by Ivan Semenov on 02.09.2023.
//

import UIKit

final class CustomTabBar: UITabBar {

    var middleButtonHandler: (() -> Void)?
    private let middleButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        addShape()
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard clipsToBounds == false, isHidden == false, alpha > 0 else { return nil }
        return middleButton.frame.contains(point) ? middleButton : super.hitTest(point, with: event)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        middleButton.center = CGPoint(x: frame.width / 2, y: 5)

        guard let items = items else { return }

        items[TabFlow.search.orderNumber].titlePositionAdjustment.horizontal = -20
        items[TabFlow.favorites.orderNumber].titlePositionAdjustment.horizontal = 20
    }

}

// MARK: - Actions

private extension CustomTabBar {

    @objc
    func handleMiddleButton() {
        middleButtonHandler?()
    }

}

// MARK: - Setup

private extension CustomTabBar {

    func setup() {
        setupTabBar()
        setupMiddleButton()
    }

    func setupTabBar() {
        tintColor = .appOrange
        barTintColor = .appBackground
        backgroundColor = .clear
        unselectedItemTintColor = .lightGray
    }

    func setupMiddleButton() {
        addSubview(middleButton)

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(.plus, withConfiguration: imageConfig)

        middleButton.frame.size = CGSize(width: 50, height: 50)
        middleButton.setImage(image, for: .normal)
        middleButton.imageEdgeInsets = .zero
        middleButton.backgroundColor = .appOrange
        middleButton.tintColor = .appBackground
        middleButton.layer.cornerRadius = middleButton.frame.height / 2
        middleButton.addTarget(self, action: #selector(handleMiddleButton), for: .touchUpInside)
    }

}

// MARK: - Shape layer

private extension CustomTabBar {

    func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.appDarkGray?.cgColor
        layer.insertSublayer(shapeLayer, at: 0)
    }

    func createPath() -> CGPath {
        let height: CGFloat = 35
        let path = UIBezierPath()
        let centerWidth = frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height), y: 0))

        path.addCurve(
            to: CGPoint(x: centerWidth, y: height),
            controlPoint1: CGPoint(x: (centerWidth - 30), y: 0),
            controlPoint2: CGPoint(x: centerWidth - 35, y: height)
        )

        path.addCurve(
            to: CGPoint(x: (centerWidth + height), y: 0),
            controlPoint1: CGPoint(x: centerWidth + 35, y: height),
            controlPoint2: CGPoint(x: (centerWidth + 30), y: 0)
        )

        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()

        return path.cgPath
    }

}
