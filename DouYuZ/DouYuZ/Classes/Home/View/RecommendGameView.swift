//
//  RecommendGameView.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/13.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
private let KGameCellID = "KGameCellID"
private let kEdageInsetMargin : CGFloat = 10
class RecommendGameView: UIView {
    //MARK: - 定义数据的属性
    var groups : [AnchorGroup]? {
        didSet {
            //1.先移除前两种数据
            groups?.removeFirst()
            groups?.removeFirst()
            //2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            collectionView.reloadData()
        }
    }
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    //MARK: - 系统回调
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        //注册cell
        collectionView.register( UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdageInsetMargin, bottom: 0, right: kEdageInsetMargin)
    }

}

//  MARK ： - 快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
//  MARK ： - 遵守UICollectionViewDatasource协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        return cell 
    }
    
    
}
