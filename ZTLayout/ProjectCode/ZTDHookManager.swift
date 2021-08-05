//
//  ZTDHookManager.swift
//  ZTLayout
//
//  Created by zhangtian on 2021/8/5.
//

import UIKit

class ZTDHookManager {
    class func install() {
        UIView.awake()
    }
}

extension UIView: ZTHook {
    public static var selectors: [Selector] {
        return [#selector(layoutSubviews), #selector(didMoveToSuperview)]
    }
}
