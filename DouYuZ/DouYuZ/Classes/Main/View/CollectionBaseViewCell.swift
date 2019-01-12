//
//  CollectionBaseViewCell.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/12.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit

class CollectionBaseViewCell: UICollectionViewCell {
    @IBOutlet weak var iconimageview: UIImageView!
    @IBOutlet weak var onlinebutton: UIButton!
    @IBOutlet weak var nickname: UILabel!
    var anchor : AnchorModel? {
        
        didSet {
            //0.检验模型是否有值
            guard let anchor = anchor else {return}
            
            //1.取出在线s人数显示的文字
            var onlineStr : String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
                
                
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlinebutton.setTitle(onlineStr, for: .normal)
            //2.昵称的显示
            nickname.text = anchor.nickname
            //4.显示封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconimageview.kf.setImage(with: iconURL)
        }
    }

    
}
