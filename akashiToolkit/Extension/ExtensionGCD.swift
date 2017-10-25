//
//  ExtensionGCD.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/23.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    ///可取消任务
    typealias Task = (_ cancel: Bool) -> Void
    ///无参无返回闭包
    typealias Closure = () -> Void
    
    ///延迟执行
    func delay(time:TimeInterval, task: @escaping Closure) -> Task? {
        
        func later(closure: @escaping Closure) {
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: closure)
        }
        
        var closure: Closure? = task
        var result: Task?
        
        let delayedClosure: Task = { cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result;
    }
    
    ///取消延迟执行
    func cancel(_ task: Task?) {
        task?(true)
    }
}
