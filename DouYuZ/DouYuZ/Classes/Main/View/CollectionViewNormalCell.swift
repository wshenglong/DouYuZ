//
//  CollectionViewNormalCell.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/10.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseViewCell {
    //MARK: - 控件s的属性 iconimageview onlinebutton nickname roomLabel
    
    
    @IBOutlet weak var roomLabel: UILabel!
    
    //定义模型属性
     override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            //3.房间名称
            roomLabel.text = anchor?.room_name

            
        }
    }
}
