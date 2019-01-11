//
//  AnchorGroup.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/11.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
@objcMembers
class AnchorGroup: NSObject {
    //该组中的对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
              anchors.append(AnchorModel(dict: dict))
                          }
        }
    }
    
    // 组显示的标题
    var tag_name : String = ""
    
    //组显示的图标
    var icon_name : String = "home_header_normal"
    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
