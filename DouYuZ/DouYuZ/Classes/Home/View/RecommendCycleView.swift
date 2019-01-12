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
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            //1.刷新collectionView
            collectionView.reloadData()
            //设置pageControl的个数
            pagecontrol.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //4.当有新数据时，添加定时器
            removeCycleTime()
            addCycleTime()
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
       
        
        collectionView.register(UINib(nibName: "CollectionCycelCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
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
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycelCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
    
    
}

//MARK:- 遵守UICollectionViewDetegate方法
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            //1.获取滚动的偏移量
        let offsetx = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //2.计算pageControl的currentIndex
        pagecontrol.currentPage = Int(offsetx / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTime() //正在拖拽时，移除定时器
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTime() //拖拽完成后，重新添加定时器
    }
}

//MARK: - 对定时器的操作方法
extension RecommendCycleView {
    private func addCycleTime() {
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeCycleTime() {
        cycleTimer?.invalidate() //从运行循环中移除
        cycleTimer = nil
    }
    @objc private func scrollToNext() {
        //1.获取滚动的偏移量
        let currentoffsetX = collectionView.contentOffset.x
        let offsetX = currentoffsetX + collectionView.bounds.width
        
        //2.滚到到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
