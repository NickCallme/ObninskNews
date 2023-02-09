//
//  KeypathConfigurable.swift
//  ExampleObnins
//
//  Created by Nikita Kolmykov on 19.01.2023.
//

import Foundation
import IOSurface

/// Протокол, позволяющий задавать значения свойств через keypath с chaining
protocol KeypathConfigurable {}

extension KeypathConfigurable where Self: AnyObject {
    
    /// Задать значения для свойства по keyPath
    /// - Parameters:
    ///   - keyPath: keyPath свойства
    ///   - value: значение
    /// - Returns: экземпляр объекта, чье свойство меняем
    func set<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>, to value: T) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}

extension NSObject: KeypathConfigurable {}
