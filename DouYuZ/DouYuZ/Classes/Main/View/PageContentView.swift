//
//  PageContentView.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2018/12/21.
//  Copyright © 2018年 jsonshenglong. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
    
}



private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    //MARK:- 属性
    private var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    private var isForbidScrollDelegate : Bool = false
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController? //父控件
    //MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //MARK:- 自定义构造函数
    //childVcs : [UIViewController], parentViewController : UIViewController 分界面控制器，也需要父控制器
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    //
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置UI界面
extension PageContentView {
    private func setupUI() {
        //1.将所有的自控制器添加到父控制器中
        for chiddVc in childVcs {
            parentViewController?.addChild(chiddVc)
        }
        //2.添加UICollectionView,用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

//MARK:- 遵守UICollectionDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //2.给Cell 设置内容
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        //        let childVc = childVcs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    
}

//MARK: - 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false //只有滚动事件可以实现
       startOffsetX = scrollView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断师傅是点击事件
        if isForbidScrollDelegate {
            return
        }
        
        //1.定义需要获取的数据 progress
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targeIndex : Int = 0

        //2.判断左滑还是右滑
        let curenntOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if curenntOffsetX > startOffsetX { //左滑
            //1.计算 progress
            progress = curenntOffsetX / scrollViewW - floor(curenntOffsetX / scrollViewW)
            
            sourceIndex = Int (curenntOffsetX / scrollViewW)
            
            targeIndex = sourceIndex + 1
            if targeIndex >= childVcs.count {
                targeIndex = childVcs.count - 1
            }
            //4.如果完全滑过去，则progress =1.0
            if curenntOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targeIndex = sourceIndex
            }
            
        } else  { //右滑
            //1.计算progress
            progress = 1 - (curenntOffsetX / scrollViewW - floor(curenntOffsetX / scrollViewW))
            //2.计算targetIndex
            targeIndex = Int (curenntOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIndex = targeIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        //3.将sourceIndex 传递给titleView
        //print("progress:\(progress) sorceIndex:\(sourceIndex) targeIndex:\(targeIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targeIndex)
    }
}

//MARK:- 对外暴露的方法 非s私有的函数 func 与 代理对象实现
extension PageContentView {
    func setCurrentIndex(_ currentIndex : Int) {
        //1.记录需要执行的代理方法
        isForbidScrollDelegate = true
        
        //2.滚动到正确位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
