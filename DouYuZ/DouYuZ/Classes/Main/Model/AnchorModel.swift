//
//  AnchorModel.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/11.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
@objcMembers
class AnchorModel: NSObject {
    //房间ID
    var room_ID : Int = 0
    //房间图片对应的URLString
    var vertical_src : String = ""
    //判断是手机直播还是电脑直播 0:电脑
    var isVertical : Int = 0
    //房间名字
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city : String = ""
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
