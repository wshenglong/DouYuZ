//
//  HomeViewController.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2018/12/21.
//  Copyright © 2018年 jsonshenglong. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //MARK: -懒加载属性
    private lazy var  pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        //titleView.backgroundColor = UIColor.orange
        return titleView
    }()
    private lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定内容的frame
       let contentH = kScreenH - kStatusBarH - kTitleViewH - kNavigationBarH
       let contentFrame = CGRect(x: 0, y: kNavigationBarH + kTitleViewH + kStatusBarH, width: kScreenW, height: contentH)
       
        //2. 确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
              vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
           
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    //MARK:- 系统回调函数viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
    }
    
    
    
}

// MARK:- 设置UI界面
extension HomeViewController {
    private func setupUI() {
        //0.不要挑战UIScrollView的内边距   ===2.00
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加PageContentView
         view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    private func setupNavigationBar() {
        //1.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}


// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndexn index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgess(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
