//
//  Synchronized.swift
//  RegexHelper
//
//  Created by huafeng chen on 2017/1/23.
//  Copyright © 2017年 huafeng chen. All rights reserved.
//

import Foundation

func synchronized(_ lock: AnyObject, closure: ()->()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
