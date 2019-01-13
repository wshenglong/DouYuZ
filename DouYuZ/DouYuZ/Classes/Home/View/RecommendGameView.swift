//
//  RecommendGameView.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/13.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
private let KGameCellID = "KGameCellID"
class RecommendGameView: UIView {
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    //MARK: - 系统回调
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KGameCellID)
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
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell 
    }
    
    
}
