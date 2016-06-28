//
//  HBVisitorView.swift
//  Weibo
//
//  Created by Beans on 16/6/25.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBVisitorView: UIView {

    // 自定义视图三部曲:
    // 1. 重写构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 2. 定义方法, 添加和布局子控件
    private func setupUI() {

    }

    // 3. 懒加载子控件 (此处以首页为例, 可后期修改)
    // 首页小房子
    private lazy var houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "visitordiscover_feed_image_house")
        imageView.sizeToFit()
        return imageView
    }()

}
