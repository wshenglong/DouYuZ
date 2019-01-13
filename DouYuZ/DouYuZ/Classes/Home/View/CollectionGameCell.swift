//
//  CollectionGameCell.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/13.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: -系统回调
    //MARK:定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            if let iconURL = URL(string: group?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
            //iconImageView.kf.setImage(with: iconURL)

        }
    }

}
