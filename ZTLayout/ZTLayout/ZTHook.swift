//
//  ZTHook.swift
//  ZTLayout
//
//  Created by zhangtian on 2021/8/5.
//

import Foundation

public protocol ZTHook: AnyObject {
    static var selectors: [Selector] {get}
    static func awake(_ selectors: [Selector])
    static func awake()
}

public extension ZTHook {
    static func awake(_ selectors: [Selector]) {
        for selector in selectors {
            let str = ("zt_" + selector.description).replacingOccurrences(of: "__", with: "_")
            if let originalMethod = class_getInstanceMethod(self, selector),
                let swizzledMethod = class_getInstanceMethod(self, Selector(str)) {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    static func awake() {
        self.awake(self.selectors)
    }
}
