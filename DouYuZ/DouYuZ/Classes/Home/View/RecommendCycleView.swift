//
//  RecommendCycleView.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/12.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {
    // MARK: 定义属性
    //var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            //1.刷新collectionView
            collectionView.reloadData()
            //设置pageControl的个数
            pagecontrol.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    //MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    
    //MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIView.AutoresizingMask()
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
  
        
    }
    //尺寸
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.isPagingEnabled = true
    }
  
}

//MARK:- 提供一个快速创建view的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
//MARK:- 遵守UICollecitonViewData的协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath)
        let cycleModel = cycleModels![indexPath.item]
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
    
    
}
