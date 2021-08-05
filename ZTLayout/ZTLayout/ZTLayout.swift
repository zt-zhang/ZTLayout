//
//  ZTLayout.swift
//  ZTLayout
//
//  Created by zhangtian on 2021/7/13.
//

import UIKit
import SnapKit

public enum ZTHVAlignment {
    case h_top
    case h_center
    case h_bottom
    case v_left
    case v_center
    case v_right
    
    case h_last_top
    case h_last_center
    case h_last_bottom
    case v_last_left
    case v_last_center
    case v_last_right
}

public extension ZTLayout {
    var subItem: [ZTLayout] {
        get {self._subItem}
        set {self._subItem = newValue}
    }
    var view: UIView {self._view}
    
    func allViews() -> [UIView] {
        var views = [UIView]()
        for item in _subItem {
            if item._subItem.count == 0 {
                views.append(item._view)
            }else {
                views.append(contentsOf: item.allViews())
            }
        }
        return views
    }
}

public typealias ZTMakerExtendable = (ConstraintMaker) -> ConstraintMakerExtendable
public class ZTLayoutConfig: NSObject {
    public var alignment: ZTHVAlignment?
    public var spacing: CGFloat?
    public var equalToSuperviews: [ZTMakerExtendable]?
    public var lessThanOrEqualToSuperviews: [ZTMakerExtendable]?
    
    public var subAlignment: ZTHVAlignment = .h_center
    public var subSpacing: CGFloat = 0
    public var subEqualToSuperviews: [ZTMakerExtendable]?
    public var subLessThanOrEqualToSuperviews: [ZTMakerExtendable]?
    
    fileprivate var tag: Int = 0
    fileprivate var row: Int = 0
    fileprivate var section: Int = 0
    
    public var height: CGFloat?
    public var heightScale: CGFloat?
    public var heightOffset: CGFloat?
    
    public var width: CGFloat?
    public var widthScale: CGFloat?
    public var widthOffset: CGFloat?
    
    public var subHeight: [CGFloat]?
    public var subHeightScale: [CGFloat]?
    public var subHeightOffset: [CGFloat]?
    
    public var subHeightEqual: CGFloat?
    public var subHeightScaleEqual: CGFloat?
    public var subHeightOffsetEqual: CGFloat?
    
    public var subWidth: [CGFloat]?
    public var subWidthScale: [CGFloat]?
    public var subWidthOffset: [CGFloat]?
    
    public var subWidthEqual: CGFloat?
    public var subWidthScaleEqual: CGFloat?
    public var subWidthOffsetEqual: CGFloat?
    
    
    // 确定行列数进行布局
    public var subGroupItemCount: [Int]?
    public var subGroupSpacing: [CGFloat]?
    public var subGroupSpacingEqual: CGFloat = 10
    
    func updateConfig(_ config: ZTLayoutConfig) {
        self.alignment = alignment ?? config.subAlignment
        self.spacing = spacing ?? config.subSpacing
        self.equalToSuperviews = equalToSuperviews ?? config.subEqualToSuperviews
        self.lessThanOrEqualToSuperviews = lessThanOrEqualToSuperviews ?? config.subLessThanOrEqualToSuperviews
        
        self.height = height ?? config.subHeightEqual ?? config.subHeight?[self.tag]
        self.heightScale = heightScale ?? config.subHeightScaleEqual ?? config.subHeightScale?[self.tag]
        self.heightOffset = heightOffset ?? config.subHeightOffsetEqual ?? config.subHeightOffset?[self.tag]
        
        self.width = width ?? config.subWidthEqual ?? config.subWidth?[self.tag]
        self.widthScale = widthScale ?? config.subWidthScaleEqual ?? config.subWidthScale?[self.tag]
        self.widthOffset = widthOffset ?? config.subWidthOffsetEqual ?? config.subWidthOffset?[self.tag]
    }
}

public class ZTEdgeItem: ZTLayout {
    public override init(_ view: UIView) {
        super.init(view)
        _config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    }
}
public class ZTRightEdgeItem: ZTLayout {
    public override init(_ view: UIView) {
        super.init(view)
        _config.equalToSuperviews = [{$0.right}]
    }
}
public class ZTBottomEdgeItem: ZTLayout {
    public override init(_ view: UIView) {
        super.init(view)
        _config.equalToSuperviews = [{$0.bottom}]
    }
}

public class ZTLayout {
    var _view: UIView
    weak var _superView: UIView?
    var _lastView: UIView?

    var _subItem: [ZTLayout] = []
    var _config: ZTLayoutConfig = .init()
    

    public init(_ view: UIView) {
        self._view = view
    }
    
    func addSubLayout(_ layout: ZTLayout) {
        layout._config.tag = _subItem.count
        layout._config.updateConfig(_config)
        _subItem.append(layout)
        _view.addSubview(layout._view)
    }
    
    func layout() {
        var lastView: UIView? = nil
        for item in self._subItem {
            if let rows = _config.subGroupItemCount {
                self.multiLineLayout(rows, view: item._view, config: item._config)
            }else {
                item._lastView = lastView
                self.layout(view: item._view, last: lastView, config: item._config)
            }
            lastView = item._view
        }
        
        _subItem.forEach{$0.layout()}
    }
    func layout(view: UIView, last: UIView?, config: ZTLayoutConfig) {
        view.snp.makeConstraints { make in
            if let last = last {
                self.alignment(make, last: last, spacing: config.spacing!, alignment: config.alignment!)
            }else {
                self.alignment(make, alignment: config.alignment!)
            }
            if let equalToSuperviews = config.equalToSuperviews {
                self.superSize(make, equalToSuperview: equalToSuperviews)
            }
            if let lessThanOrEqualToSuperviews = config.lessThanOrEqualToSuperviews {
                self.superSize(make, lessThanOrEqualToSuperviews: lessThanOrEqualToSuperviews)
            }
            self.width(make, config: config)
            self.height(make, config: config)
        }
    }
    func multiLineLayout(_ rows: [Int], view: UIView, config: ZTLayoutConfig) {
        var _last: UIView? = nil
        var _tops: [UIView]? = nil
        var _sections: [[UIView]] = .init()
        
        var last: UIView? = nil
        var tops: [UIView]? = nil
        var sum: Int = 0
        
        var row: Int = 0
        var sectioin: Int = 0
        
        for i in rows {
            var views = [UIView]()
            for j in sum..<sum+i  {
                if j == config.tag {
                    config.row = row
                    config.section = sectioin
                    _last = last
                    _tops = .init(tops ?? [])
                }
                last = _subItem[j]._view //子View数 小于 行列数
                views.append(last!)
                row += 1
            }
            _sections.append(views)
            tops = views
            last = nil
            sum += i
            sectioin += 1
            row = 0
        }
        
        self.multiLineLayout(view: view, config: config, last: _last, tops: _tops, sections: _sections)
    }
    func multiLineLayout(view: UIView, config: ZTLayoutConfig, last: UIView?, tops: [UIView]?, sections: [[UIView]]) {
        var isBottom: Bool = false
        var isRight: Bool = false
        var isTop: Bool = false
        
        for views in sections {
            for v in views {
                if view == v {
                    isRight = view == views.last
                    isBottom = views == sections.last
                    isTop = views == sections.first
                }
            }
        }
        
        view.snp.makeConstraints { make in
            let groupSpacing = _config.subGroupSpacing?[config.section] ?? _config.subGroupSpacingEqual
            if let last = last {
                self.alignment(make, last: last, tops: tops, spacing: config.spacing!, groupSpacing: groupSpacing, alignment: config.alignment!)
            }else {
                self.alignment(make, tops: tops, groupSpacing: groupSpacing, alignment: config.alignment!)
            }
            // size
            if isBottom {
                switch config.alignment! {
                case .h_center, .h_last_center, .h_top, .h_last_top, .h_bottom, .h_last_bottom:
                    make.bottom.lessThanOrEqualToSuperview()
                case .v_left, .v_last_left, .v_center, .v_last_center, .v_right, .v_last_right:
                    make.right.lessThanOrEqualToSuperview()
                }
            }
            if isRight {
                switch config.alignment! {
                case .h_center, .h_last_center, .h_top, .h_last_top, .h_bottom, .h_last_bottom:
                    make.right.lessThanOrEqualToSuperview()
                case .v_left, .v_last_left, .v_center, .v_last_center, .v_right, .v_last_right:
                    make.bottom.lessThanOrEqualToSuperview()
                }
            }
            if isTop {
                switch config.alignment! {
                case .h_center, .h_last_center, .h_top, .h_last_top, .h_bottom, .h_last_bottom:
                    make.top.greaterThanOrEqualToSuperview()
                case .v_left, .v_last_left, .v_center, .v_last_center, .v_right, .v_last_right:
                    make.left.greaterThanOrEqualToSuperview()
                }
            }
            self.width(make, config: config)
            self.height(make, config: config)
        }
    }
}

extension ZTLayout {
    func alignment(_ make: ConstraintMaker, tops: [UIView]?, groupSpacing: CGFloat, alignment: ZTHVAlignment) {
        switch alignment {
        case .h_last_center, .h_center, .h_last_top, .h_top, .h_last_bottom, .h_bottom:
            make.left.equalToSuperview()
            if let tops = tops {
                for top in tops {
                    make.top.greaterThanOrEqualTo(top.snp.bottom).offset(groupSpacing)
                }
            }else {
                make.top.greaterThanOrEqualToSuperview()
            }
        case .v_last_left, .v_left, .v_last_center, .v_center, .v_last_right, .v_right:
            make.top.equalToSuperview()
            if let tops = tops {
                for top in tops {
                    make.left.greaterThanOrEqualTo(top.snp.right).offset(groupSpacing)
                }
            }else {
                make.left.greaterThanOrEqualToSuperview()
            }
        }
    }
    func alignment(_ make: ConstraintMaker, last: UIView, tops: [UIView]?, spacing: CGFloat, groupSpacing: CGFloat, alignment: ZTHVAlignment) {
        switch alignment {
        case .h_last_center, .h_center:
            make.centerY.equalTo(last)
            make.left.equalTo(last.snp.right).offset(spacing)
        case .h_last_top, .h_top:
            make.top.equalTo(last)
            make.left.equalTo(last.snp.right).offset(spacing)
        case .h_last_bottom, .h_bottom:
            make.bottom.equalTo(last)
            make.left.equalTo(last.snp.right).offset(spacing)
        case .v_last_left, .v_left:
            make.left.equalTo(last)
            make.top.equalTo(last.snp.bottom).offset(spacing)
        case .v_last_center, .v_center:
            make.centerX.equalTo(last)
            make.top.equalTo(last.snp.bottom).offset(spacing)
        case .v_last_right, .v_right:
            make.right.equalTo(last)
            make.top.equalTo(last.snp.bottom).offset(spacing)
        }
        
        switch alignment {
        case .h_last_center, .h_center, .h_last_top, .h_top, .h_last_bottom, .h_bottom:
            if let tops = tops {
                for top in tops {
                    make.top.greaterThanOrEqualTo(top.snp.bottom).offset(groupSpacing)
                }
            }else {
                make.top.greaterThanOrEqualToSuperview()
            }
        case .v_last_left, .v_left, .v_last_center, .v_center, .v_last_right, .v_right:
            if let tops = tops {
                for top in tops {
                    make.left.greaterThanOrEqualTo(top.snp.right).offset(groupSpacing)
                }
            }else {
                make.left.greaterThanOrEqualToSuperview()
            }
        }
    }
    
    func alignment(_ make: ConstraintMaker, last: UIView, spacing: CGFloat, alignment: ZTHVAlignment) {
        switch alignment {
        case .h_center:
            make.centerY.equalToSuperview()
            make.left.equalTo(last.snp.right).offset(spacing)
        case .h_top:
            make.top.equalToSuperview()
            make.left.equalTo(last.snp.right).offset(spacing)
        case .h_bottom:
            make.bottom.equalToSuperview()
            make.left.equalTo(last.snp.right).offset(spacing)
        case .v_left:
            make.left.equalToSuperview()
            make.top.equalTo(last.snp.bottom).offset(spacing)
        case .v_center:
            make.centerX.equalToSuperview()
            make.top.equalTo(last.snp.bottom).offset(spacing)
        case .v_right:
            make.right.equalToSuperview()
            make.top.equalTo(last.snp.bottom).offset(spacing)
            
        case .h_last_center:
            make.centerY.equalTo(last)
            make.left.equalTo(last.snp.right).offset(spacing)
        case .h_last_top:
            make.top.equalTo(last)
            make.left.equalTo(last.snp.right).offset(spacing)
        case .h_last_bottom:
            make.bottom.equalTo(last)
            make.left.equalTo(last.snp.right).offset(spacing)
        case .v_last_left:
            make.left.equalTo(last)
            make.top.equalTo(last.snp.bottom).offset(spacing)
        case .v_last_center:
            make.centerX.equalTo(last)
            make.top.equalTo(last.snp.bottom).offset(spacing)
        case .v_last_right:
            make.right.equalTo(last)
            make.top.equalTo(last.snp.bottom).offset(spacing)
        }
    }
    
    func alignment(_ make: ConstraintMaker, alignment: ZTHVAlignment) {
        switch alignment {
        case .h_center, .h_last_center:
            make.top.left.equalToSuperview()
        case .h_top, .h_last_top:
            make.top.left.equalToSuperview()
        case .h_bottom, .h_last_bottom:
            make.bottom.left.equalToSuperview()
            
        case .v_left, .v_last_left:
            make.left.top.equalToSuperview()
        case .v_center, .v_last_center:
            make.centerX.top.equalToSuperview()
        case .v_right, .v_last_right:
            make.right.top.equalToSuperview()
        }
    }
    
    func superSize(_ make: ConstraintMaker, lessThanOrEqualToSuperviews: [ZTMakerExtendable]) {
        for me in lessThanOrEqualToSuperviews {
            me(make).lessThanOrEqualToSuperview()
        }
    }
    func superSize(_ make: ConstraintMaker, equalToSuperview: [ZTMakerExtendable]) {
        for me in equalToSuperview {
            me(make).equalToSuperview()
        }
    }
    
    func width(_ make: ConstraintMaker, config: ZTLayoutConfig) {
        if let width = config.width {
            make.width.equalTo(width)
        }
        if let widthScale = config.widthScale {
            let offset = config.widthOffset ?? 0
            make.width.equalToSuperview().multipliedBy(widthScale).offset(offset)
        }
    }
    func height(_ make: ConstraintMaker, config: ZTLayoutConfig) {
        if let height = config.height {
            make.height.equalTo(height)
        }
        if let heightScale = config.heightScale {
            let offset = config.heightOffset ?? 0
            make.height.equalToSuperview().multipliedBy(heightScale).offset(offset)
        }
    }
}
