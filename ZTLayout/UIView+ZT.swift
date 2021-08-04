//
//  UIView+ZT.swift
//  ZTLayout
//
//  Created by zhangtian on 2021/7/3.
//

import UIKit
import SnapKit

public extension UIView {
    private struct AssociatedKeys {
        static var zt_width = "zt_width"
        static var zt_width_scale = "zt_width_scale"
        static var zt_width_offset = "zt_width_offset"
        
        static var zt_height = "zt_height"
        static var zt_height_scale = "zt_height_scale"
        static var zt_height_offset = "zt_height_offset"
    }
    
    var zt_width: CGFloat {
        get {
            if let data = objc_getAssociatedObject(self, &AssociatedKeys.zt_width) as? CGFloat {return data}
            self.zt_width = 0
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_width, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    var zt_height: CGFloat {
        get {
            if let data = objc_getAssociatedObject(self, &AssociatedKeys.zt_height) as? CGFloat {return data}
            self.zt_height = 0
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_height, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    
    var zt_width_scale: CGFloat {
        get {
            if let data = objc_getAssociatedObject(self, &AssociatedKeys.zt_width_scale) as? CGFloat {return data}
            self.zt_width_scale = 0
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_width_scale, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    var zt_width_offset: CGFloat {
        get {
            if let data = objc_getAssociatedObject(self, &AssociatedKeys.zt_width_offset) as? CGFloat {return data}
            self.zt_width_offset = 0
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_width_offset, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    var zt_height_scale: CGFloat {
        get {
            if let data = objc_getAssociatedObject(self, &AssociatedKeys.zt_height_scale) as? CGFloat {return data}
            self.zt_height_scale = 0
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_height_scale, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    var zt_height_offset: CGFloat {
        get {
            if let data = objc_getAssociatedObject(self, &AssociatedKeys.zt_height_offset) as? CGFloat {return data}
            self.zt_height_offset = 0
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_height_offset, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

extension UIView {
    @objc func zt_didMoveToSuperview() {
        self.zt_didMoveToSuperview()
        
        
        if let _ = self.superview, self.zt_width > 0 {
            self.snp.makeConstraints { make in
                make.width.equalTo(zt_width)
            }
        }
        if let _ = self.superview, self.zt_height > 0 {
            self.snp.makeConstraints { make in
                make.height.equalTo(zt_height)
            }
        }
        if let _ = self.superview, self.zt_width_scale > 0 {
            self.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(zt_width_scale).offset(zt_width_offset)
            }
        }
        if let _ = self.superview, self.zt_height_scale > 0 {
            self.snp.makeConstraints { make in
                make.height.equalToSuperview().multipliedBy(zt_height_scale).offset(zt_height_offset)
            }
        }
    }
}

public extension UIView {
    func zt_size(_ W: CGFloat = 0, _ H: CGFloat = 0) {
        self.zt_width = W
        self.zt_height = H
    }
    func zt_size(scaleW: CGFloat = 0, scaleH: CGFloat = 0, offsetW: CGFloat = 0, offsetH: CGFloat = 0) {
        self.zt_width_scale = scaleW
        self.zt_width_offset = offsetW
        self.zt_height_scale = scaleH
        self.zt_height_offset = offsetH
    }
}
