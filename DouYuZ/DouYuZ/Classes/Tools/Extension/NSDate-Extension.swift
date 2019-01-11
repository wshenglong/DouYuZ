//
//  NSDate-Extension.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/11.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrenTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
