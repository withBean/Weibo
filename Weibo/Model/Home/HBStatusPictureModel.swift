//
//  HBStatusPictureModel.swift
//  Weibo
//
//  Created by Beans on 16/7/16.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBStatusPictureModel: NSObject {

    var thumbnail_pic: String?

    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}
