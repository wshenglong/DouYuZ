//
//  PageTitleView.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2018/12/21.
//  Copyright © 2018年 jsonshenglong. All rights reserved.
//

import UIKit
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndexn index :Int)
    
}
private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    
    //MARK: -定义属性
    private var titles : [String]
    private var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: -懒加载属性scrollview
    private lazy var titleLables : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK: -懒加载属性scrollLine
    private lazy var scrollLine : UIView = {
       let scrollLine = UIView()
       scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK: -自定义构造函数  必须使用init(coder:)
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -设置UI界面
extension PageTitleView {
    private func setupUI() {
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title 对应的lable
        setupTitleLables()
        
        //3.设置底线和滚动的滑块
        setupBottonMenuAndScrollLine()
        
    }
    
    
    private func setupTitleLables() {
        
        //0.确定lable 的一些frame的值
        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - kScrollLineH

        let lableY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建UILable
            let lable = UILabel()
            
            //2.设置Lable 的属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
            //3.设置lable 的frame
            let lableX : CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            //4.将lable添加到scrollView
            scrollView.addSubview(lable)
            titleLables.append(lable)
            
            //5.给Label添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            lable.addGestureRecognizer(tapGes)
            
        }
    }
    
    private func setupBottonMenuAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加srollLine
        //2.1 获取第一个lable
        guard let firtLable = titleLables.first else {
            return
        }
        firtLable.textColor = UIColor.orange
        
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firtLable.frame.origin.x, y: frame.height - kScrollLineH, width: firtLable.frame.width, height: kScrollLineH)
        
    }
}


//MARK:- 监听Label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
       //1.获取当前lable的下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        //2.获取之前的label的下标值
        let oldLabel = titleLables[currentIndex]
        //3.切换文字y的 颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        //5.滚动条位置发生改变
        let scrollLineX =  CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6.通知dialing
        delegate?.pageTitleView(titleView: self, selectedIndexn: currentIndex)
    }
}
//MARK:- 对外暴露方法
extension PageTitleView {
    func setTitleWithProgess(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
    }
}
