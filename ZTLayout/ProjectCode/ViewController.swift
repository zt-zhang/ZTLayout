//
//  ViewController.swift
//  ZTLayout
//
//  Created by zhangtian on 2021/8/5.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    lazy var scrollerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollerView)
        scrollerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(88)
        }
        layoutUI()
    }
    
    func layoutUI() {
        scrollerView
            *>> {
                $0.subAlignment = .v_center
                $0.subSpacing = 20
            }
            >>> ztlayoutDemo01()
            >>> ztlayoutDemo02()
            >>> ztlayoutDemo03()
            /> "end"
    }

    var ztview01: UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.zt_width = CGFloat(arc4random_uniform(50)+20)
        view.zt_height = CGFloat(arc4random_uniform(30)+20)
        return view
    }
    
    func ztlayoutDemo01() -> ZTLayout {
        let cig = ZTLayoutConfig()
        cig.subAlignment = .v_center
        cig.subSpacing = 10
        cig.subLessThanOrEqualToSuperviews = [{$0.right}]
        
        return
            UIView.color(.lightGray)
            *>> cig
            >>> {sup in
                [Int](0..<4).forEach{_ in sup >>> ztview01}
                //sup >>/ ztview01
            }
            >>/ ztview01
    }
    
    var config01: ZTLayoutConfig {
        let cig = ZTLayoutConfig()
        cig.subAlignment = .v_right
        cig.subSpacing = 10
        cig.subLessThanOrEqualToSuperviews = [{$0.width}]
        return cig
    }
    var config02: ZTLayoutConfig {
        let cig = ZTLayoutConfig()
        cig.subAlignment = .h_center
        cig.subSpacing = 10
        cig.subLessThanOrEqualToSuperviews = [{$0.bottom}]
        return cig
    }
    func ztlayoutDemo02() -> ZTLayout {
        UIView.color(.lightGray) *>> config01
            >>> UIView.color(.blue) *>> config02
                ++> ztview01
                ++> ztview01
                ++> ztview01
                ++| ztview01
            >>> UIView.color(.blue) *>> config02
                ++> ztview01
                ++> ztview01
                ++> ztview01
                ++| ztview01
            >>/ UIView.color(.blue) *>> config02
                ++> ztview01
                ++> ztview01
                ++> ztview01
                ++| ztview01
    }
    
    func ztlayoutDemo03() -> ZTLayout {
        let cig = ZTLayoutConfig()
        cig.subAlignment = .h_bottom
        cig.subSpacing = 10
        cig.subGroupItemCount = [2,3,4,5]
        cig.subGroupSpacingEqual = 20
        //cig.subGroupSpacing = [10, 20, 30, 40]
        
        return
            UIView.color(.lightGray) *>> cig
            >>> {sup in
                let count = cig.subGroupItemCount!.reduce(0, {$0+$1})
                [Int](0..<count).forEach{_ in sup >>> ztview01}
            }
    }
}

extension UIView {
    class func color(_ color: UIColor) -> UIView {
        let v = UIView()
        v.backgroundColor = color
        return v
    }
}

