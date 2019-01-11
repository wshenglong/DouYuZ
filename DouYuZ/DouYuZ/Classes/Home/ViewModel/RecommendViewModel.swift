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
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

//MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData() {
        //1.请求推荐数据
        
        //2.请求第二部分颜值数据
        
        //3.请求后面部分的游戏数据
        // time : 1547183768.9498382
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1547183768.9498382
        
        print(NSDate.getCurrenTime())
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .get, parameters: ["limit": "4", "offset": "0","time": NSDate.getCurrenTime()]) { (result) in
            print(result)
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
                    print(anchor.nickname)
                }
                 print("--------")
            }
        }

    }
    
}

//
//private func loadData() {
//}
