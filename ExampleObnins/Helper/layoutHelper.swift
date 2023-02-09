//
//  layoutHelper.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation
import UIKit
import SwiftUI

/// Билдер констреинтов
@resultBuilder
enum ConstraintBuilder {
    static func buildExpression(_ expression: NSLayoutConstraint?) -> NSLayoutConstraint {
        return expression ?? NSLayoutConstraint()
    }

    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return Array(components)
    }
}

extension UIView {
    
    /// Добавить сабвью
    /// - Parameter subviews: набор сабвью
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }

    /// Собрать лэйаут
    /// - Parameter builder: билдер блок констреинтов
    func layout(@ConstraintBuilder using builder: () -> [NSLayoutConstraint]) {
        layout(using: builder())
    }

    /// Собрать лэйаут
    /// - Parameter constraints: набор констреинтов
    func layout(using constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }

    /// Прикрепить вью к супервью
    func layoutEqualToSuperview() {
        guard let superview = superview else { return }
        layoutEqual(to: superview)
    }

    /// Прикрпить вью к другой вью
    /// - Parameters:
    ///   - view: другая вью
    ///   - insets: отступы
    func layoutEqual(to view: UIView,insets: UIEdgeInsets = .zero) {
        layout {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left)
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right)
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        }
    }

    /// Пересобрать layout
    /// - Parameters:
    ///   - animated: использовать ли анимацию
    ///   - duration: длительность анимации
    ///   - options: опции анимации
    ///   - completion: обработчик, вызываемый при завершении
    func rebuildLayout(
        animated: Bool = false,
        duration: Double = 0.2,
        options: UIView.AnimationOptions = [],
        completion: ((Bool) -> Void)? = nil
    ) {
        if animated || duration > 0 {
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: options,
                           animations: {
                               self.setNeedsLayout()
                               self.layoutIfNeeded()
                           }, completion: completion)
        } else {
            setNeedsLayout()
            layoutIfNeeded()
            completion?(true)
        }
    }
    
}

extension NSLayoutConstraint {
    /// Возвращает констрэинт с выставленным приоритетом
    ///
    /// - Parameter priority: приоритет
    /// - Returns: констрэинт с выставленным приоритетом
    @discardableResult func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    /// Возвращает констрэинт с выставленным приоритетом
    ///
    /// - Parameter priority: приоритет
    /// - Returns: констрэинт с выставленным приоритетом
    @discardableResult func priority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = .init(priority)
        return self
    }

    /// Активировать констрэинт
    @discardableResult func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }

    // Деактивировать констрэинт
    @discardableResult func deactivate() -> NSLayoutConstraint {
        isActive = false
        return self
    }
}
