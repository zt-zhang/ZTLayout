//
//  ZTOperators.swift
//  ZTLayout
//
//  Created by zhangtian on 2021/7/3.
//

import UIKit

precedencegroup ZTSettingPrecedence {
    associativity: left
    higherThan: ZTAppendPrecedence4
}
precedencegroup ZTAppendPrecedence1 {
    associativity: left
    higherThan: ZTEndPrecedence
}
precedencegroup ZTAppendPrecedence2 {
    associativity: left
    higherThan: ZTAppendPrecedence1
}
precedencegroup ZTAppendPrecedence3 {
    associativity: left
    higherThan: ZTAppendPrecedence2
}
precedencegroup ZTAppendPrecedence4 {
    associativity: left
    higherThan: ZTAppendPrecedence3
}
precedencegroup ZTEndPrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

infix operator *>> : ZTSettingPrecedence
infix operator /> : ZTEndPrecedence

infix operator >>> : ZTAppendPrecedence1
infix operator >>| : ZTAppendPrecedence1
infix operator >>/ : ZTAppendPrecedence1
infix operator >>>/ : ZTAppendPrecedence1

infix operator ++> : ZTAppendPrecedence2
infix operator ++| : ZTAppendPrecedence2
infix operator ++/ : ZTAppendPrecedence2
infix operator ++>/ : ZTAppendPrecedence2

infix operator +++> : ZTAppendPrecedence3
infix operator +++| : ZTAppendPrecedence3
infix operator +++/ : ZTAppendPrecedence3
infix operator +++>/ : ZTAppendPrecedence3

infix operator ++++> : ZTAppendPrecedence4
infix operator ++++| : ZTAppendPrecedence4
infix operator ++++/ : ZTAppendPrecedence4
infix operator ++++>/ : ZTAppendPrecedence4


// MARK: -
public func /> (left: ZTLayout, right: String? = nil) {
    left.layout()
}

public func *>> (left: ZTLayout, right: (ZTLayoutConfig) -> () ) -> ZTLayout {
    right(left._config)
    return left
}
public func *>> (left: UIView, right: (ZTLayoutConfig) -> () ) -> ZTLayout {
    let left = ZTLayout(left)
    right(left._config)
    return left
}
public func *>> (left: ZTLayout, right: ZTLayoutConfig) -> ZTLayout {
    left._config = right
    return left
}
public func *>> (left: UIView, right: ZTLayoutConfig) -> ZTLayout {
    let left = ZTLayout(left)
    left._config = right
    return left
}

// MARK: -
@discardableResult
public func >>> ( left: ZTLayout, right: (ZTLayout) -> ()) -> ZTLayout {
    right(left)
    return left
}
// MARK: -
@discardableResult
public func >>> ( left: ZTLayout, right: () -> ZTLayout)-> ZTLayout {
    let right = right()
    left.addSubLayout(right)
    return left
}
@discardableResult
public func >>| ( left: ZTLayout, right: () -> ZTLayout)-> ZTLayout {
    let right = right()
    left.addSubLayout(right)
    return left
}
@discardableResult
public func >>/ ( left: ZTLayout, right: () -> ZTLayout)-> ZTLayout {
    let right = right()
    left.addSubLayout(right)
    return left
}
@discardableResult
public func >>>/ ( left: ZTLayout, right: () -> ZTLayout)-> ZTLayout {
    let right = right()
    left.addSubLayout(right)
    return left
}

// MARK: -
@discardableResult
public func >>> ( left: UIView, right: () -> ZTLayout)-> ZTLayout {
    let left = ZTLayout(left)
    let right = right()
    left.addSubLayout(right)
    return left
}
@discardableResult
public func >>| ( left: UIView, right: () -> ZTLayout)-> ZTLayout {
    let left = ZTLayout(left)
    let right = right()
    left.addSubLayout(right)
    return left
}
@discardableResult
public func >>/ ( left: UIView, right: () -> ZTLayout)-> ZTLayout {
    let left = ZTLayout(left)
    let right = right()
    left.addSubLayout(right)
    return left
}
@discardableResult
public func >>>/ ( left: UIView, right: () -> ZTLayout)-> ZTLayout {
    let left = ZTLayout(left)
    let right = right()
    left.addSubLayout(right)
    return left
}


@discardableResult
public func >>> ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    return left
}
@discardableResult
public func ++> ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    return left
}
@discardableResult
public func +++> ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    return left
}
@discardableResult
public func ++++> ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    return left
}

@discardableResult
public func >>> ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}
@discardableResult
public func ++> ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}
@discardableResult
public func +++> ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}
@discardableResult
public func ++++> ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}

@discardableResult
public func >>> ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}
@discardableResult
public func ++> ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}
@discardableResult
public func +++> ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}
@discardableResult
public func ++++> ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    return left
}

// MARK: -
@discardableResult
public func >>| ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func ++| ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func +++| ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func ++++| ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}

@discardableResult
public func >>| ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func ++| ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func +++| ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func ++++| ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}

@discardableResult
public func >>| ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func ++| ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func +++| ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}
@discardableResult
public func ++++| ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}]
    return left
}

// MARK: -
@discardableResult
public func >>/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func ++/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func +++/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func ++++/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}

@discardableResult
public func >>/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func ++/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func +++/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func ++++/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}

@discardableResult
public func >>/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func ++/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func +++/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}
@discardableResult
public func ++++/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.bottom}]
    return left
}

// MARK: -
@discardableResult
public func >>>/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func ++>/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func +++>/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func ++++>/ ( left: ZTLayout, right: ZTLayout)-> ZTLayout {
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}

@discardableResult
public func >>>/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func ++>/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func +++>/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func ++++>/ ( left: ZTLayout, right: UIView)-> ZTLayout {
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}

@discardableResult
public func >>>/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func ++>/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func +++>/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
@discardableResult
public func ++++>/ ( left: UIView, right: UIView)-> ZTLayout {
    let left = ZTLayout(right)
    let right = ZTLayout(right)
    left.addSubLayout(right)
    right._config.equalToSuperviews = [{$0.right}, {$0.bottom}]
    return left
}
