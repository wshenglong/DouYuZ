//
//  CollectionCycelCell.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/12.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit

class CollectionCycelCell: UICollectionViewCell {
    //MARK: 定义模型属性

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
    
    
}
