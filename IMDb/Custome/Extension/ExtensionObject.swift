//
//  Extension+NSObject.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

public class Debouncer: NSObject {
    public var callback: (() -> Void)
    public var delay: Double
    public weak var timer: Timer?
 
    public init(delay: Double, callback: @escaping (() -> Void)) {
        self.delay = delay
        self.callback = callback
    }
 
    public func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }
 
    @objc func fireNow() {
        self.callback()
    }
}
