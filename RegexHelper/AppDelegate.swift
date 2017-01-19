//
//  AppDelegate.swift
//  RegexHelper
//
//  Created by huafeng chen on 2017/1/19.
//  Copyright © 2017年 huafeng chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // 正则表达式30分钟入门教程
        // http://deerchao.net/tutorials/regex/regex.htm
        
        // 8个常用正则表达式
        // https://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149
        let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        
        let matcher: RegexHelper
        do {
            matcher = try! RegexHelper(mailPattern)
        }
        
        let maybeMailAddres = "chenhuafeng@yy.com"
        
        if matcher.match(maybeMailAddres) {
            print("有效的邮箱地址")
        }
        
        if "459756460@qq.com" =~ mailPattern {
            print("有效的邮箱地址")
        }
        
        return true
    }



}

