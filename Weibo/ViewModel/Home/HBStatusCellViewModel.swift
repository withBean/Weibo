//
//  HBStatusCellViewModel.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBStatusCellViewModel: NSObject {
    
    var model: HBStatusModel?
    init(model: HBStatusModel) {
        self.model = model
    }
}
