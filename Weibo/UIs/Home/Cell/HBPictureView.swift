//
//  HBPictureView.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

let HBPictureViewCellReuseID = "HBPictureViewCellReuseID"

let colCount = 3
let itemMargin: CGFloat = 5
let itemWH: CGFloat = (kScreenWidth - cellMargin * 2 - itemMargin * (CGFloat(colCount) - 1)) / CGFloat(colCount)

class HBPictureView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var viewModel: HBStatusCellViewModel? {
        didSet {
            // 配图的尺寸, 由图片数量决定
            let picViewSize = calculateSize()
            self.snp_updateConstraints { (make) in
                make.size.equalTo(picViewSize)
            }
            // 刷新数据
            reloadData()
        }
    }

    /* UICollectionView must be initialized with a non-nil layout parameter */
    var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        // 注册cell
        self.registerClass(HBPictureViewCell.self, forCellWithReuseIdentifier: HBPictureViewCellReuseID)
        dataSource = self
        delegate = self

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = colorWithHSB(40, saturation: 60, brightness: 100)
        self.bounces = false

        flowLayout.itemSize = CGSizeMake(itemWH, itemWH)
        flowLayout.minimumInteritemSpacing = itemMargin
        flowLayout.minimumLineSpacing = itemMargin
    }

    // MARK: - 计算配图尺寸
    private func calculateSize() -> CGSize {
        /** 图片大小的计算逻辑
         1. 1张图片 实际图片大小(控制宽高)
         2. 4张图片 2*2
         3. 其他图片数量 1*3 2*3 3*3
         */
        guard let picCount = viewModel?.pic_urls?.count else {
            return CGSizeZero
        }

        if picCount == 0 {
            return CGSizeZero
        }

        if picCount == 1 {
            // temp
            return CGSizeMake(itemWH, itemWH)

        } else {
            // 由于cell存在重用, 需要把上边改过的再恢复为原来的
//            flowLayout.itemSize = CGSizeMake(itemWH, itemWH)
        }

        if picCount == 4 {
            return CGSizeMake(itemWH * 2 + itemMargin, itemWH * 2 + itemMargin)
        }

        // 其它张数, 统一返回默认宽高 (按9张图计算)
        let row = (picCount - 1) / 3 + 1;
        return CGSizeMake(kScreenWidth - 2 * cellMargin, (itemWH + itemMargin) * CGFloat(row))
//        return CGSizeMake(300, 300)
    }

    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.pic_urls?.count ?? 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HBPictureViewCellReuseID, forIndexPath: indexPath) as! HBPictureViewCell
        cell.backgroundColor = color_HSB_Random()
        cell.model = viewModel?.pic_urls![indexPath.item]   // MVVM -> MVC

        return cell
    }
}

class HBPictureViewCell: UICollectionViewCell {

//    var viewModel: HBStatusPictureViewModel? {  // (MVVM, 需将model中pic_urls改为viewModel才可以, 此处使用MVC如下)
//        didSet {
//            picImgView.sd_setImageWithURL(viewModel?.picURL)
//        }
//    }
    var model: HBStatusPictureModel? {      // 此处用的是MVC, 否则要改很多地方
        didSet {
            if let pic_url = model?.thumbnail_pic {
                picImgView.sd_setImageWithURL(NSURL(string: pic_url))
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = UIColor.redColor()
        contentView.addSubview(picImgView)
        picImgView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }

    // MARK: - lazy load
    private lazy var picImgView: UIImageView = UIImageView()
}
