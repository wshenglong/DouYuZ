//
//  CollectionPrettyCell.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/10.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseViewCell {
//定义模型属性
    //var anchor : AnchorModel?
    //MARK: - 定义模型属性
    

    @IBOutlet weak var citybutton: UIButton!
    override var anchor : AnchorModel? {
        
        didSet {
            //1.将属相传递给父类
            super.anchor = anchor
            
            //3.所在的城市
            citybutton.setTitle(anchor?.anchor_city, for: .normal)

        }
    }

}
