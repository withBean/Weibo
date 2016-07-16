//
//  HBStatusPictureViewModel.swift
//  Weibo
//
//  Created by Beans on 16/7/16.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBStatusPictureViewModel: NSObject {

    var model: HBStatusPictureModel?

    init(model: HBStatusPictureModel) {
        self.model = model
        super.init()
    }

    // MARK: - 配图的数据处理
    var picURL: NSURL? {
        if let pic_url = model?.thumbnail_pic {
            return NSURL(string: pic_url)
        } else {
            return NSURL()
        }
    }
}
