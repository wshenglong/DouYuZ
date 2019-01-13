//
//  RecommendViewController.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/10.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH  : CGFloat = 90//kScreenW * 3 / 8

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kHeaderViewH : CGFloat = 50



class RecommendViewController: UIViewController {
    //MARK:- 懒加载属性
     fileprivate lazy var recommendVM : RecommendViewModel =  RecommendViewModel()
     fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
     private lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2.创建UICollectionView
        print(self.view.bounds)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
    }()
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        //gameView.backgroundColor = UIColor.red
        return gameView
    }()
    
    
    //MARK：- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //设置UI界面
        setupUI()
      //发送网络请求
        loadData()
        
    }
    

}

//MARK: - 设置UI界面l内容
extension RecommendViewController {
    private func setupUI() {
        //1.将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
        //2.将CycleViewi添加到UICollectionView中
       collectionView.addSubview(cycleView)
        //3.将gameView添加到collectionView中
        collectionView.addSubview(gameView)
        //4.设置collectionView的内边距上部预留30
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}
//MARK: - 请求数据
extension RecommendViewController {
    private func loadData() {
        //1.请求数据
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
          self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }

}






//MARK: - 准守UICollectionDataSource
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     let group = recommendVM.anchorGroups[section]
        return group.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        //1.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        //2.定义cell
        var cell : CollectionBaseViewCell!
        
        
        //3.获取cell
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell

        } else {
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell

        }
        //4.将模型赋值给cell
        cell.anchor = anchor
        return cell
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
       
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        //2.取出模型
       headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        
        
        return headerView
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
   
}
