//
//  RecommendViewModel.swift
//  DouYuZ
//
//  Created by jsonshenglong on 2019/1/10.
//  Copyright © 2019年 jsonshenglong. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //MARK: - 懒加载属性
    // 0 1 放入数据
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

//MARK:- 发送网络请求
extension RecommendViewModel {
    
    //请求推荐数据
    func requestData(finishCallback : @escaping () -> ()) {
        //0.定义参数
        let parameters = ["limit": "4", "offset": "0","time": NSDate.getCurrenTime()]
        //1创建Group
        let dGroup = DispatchGroup()
        //2请求第一部分数据
        dGroup.enter()
        
        
        
        //4.请求第一部分推荐数据http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1547183768
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parameters: ["time" : NSDate.getCurrenTime()]) { (result) in
            //1.将result转换成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            //2.根据data该key ,获取数组,数组里是字典
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.便利字典，并且转换成模型对象
            //3.1创建组
            //3.2设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.3获取主播数据
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            //3.4离开组
            dGroup.leave()
           
        }
        
        //4.请求第二部分颜值数据http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1547183768
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: parameters) { (result) in
            //1.将result转换成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            //2.根据data该key ,获取数组,数组里是字典
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.便利字典，并且转换成模型对象
            //3.1创建组
            //3.2设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.3获取主播数据
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //4.离开组
              dGroup.leave()
           
            
        }
        //5.请求2-12部分的游戏数据
        // time : 1547183768.9498382
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1547183768.9498382
         dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .get, parameters: parameters) { (result) in
           
            //1.将result转换成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                return
            }
            //2.根据data该key ,获取数组,数组里是字典
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.便利数组，获取字典，并且将字典转换成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups {
                for anchor in group.anchors {
                    //print(anchor.nickname)
                }
                 //print("--------")
            }
            //4.离开组
             dGroup.leave()
            
        }
        //6.
        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            //排序
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
      
        }
        
    }
    
    //请求无限轮播数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        //URL::http://www.douyutv.com/api/v1/slide/6
        
        NetworkTools.requestData(URLString: "http://www.douyutv.com/api/v1/slide/6", type: .get, parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体s字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray {
               self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }
    }
    
}

//
//private func loadData() {
//}
