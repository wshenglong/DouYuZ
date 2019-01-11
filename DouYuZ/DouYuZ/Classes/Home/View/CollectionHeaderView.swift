//
//  CollectionHeaderView.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/10.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //MARK: - 添加控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon_image_view: UIImageView!
    
    //MARK: - 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            icon_image_view.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}
