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

class HBPictureView: UICollectionView {

    var pic_urls: [HBStatusPictureViewModel]?

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

    // MARK: - lazy load
}

extension HBPictureView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pic_urls?.count ?? 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HBPictureViewCellReuseID, forIndexPath: indexPath) as! HBPictureViewCell
        cell.backgroundColor = color_HSB_Random()
        cell.viewModel = pic_urls![indexPath.item]

        return cell
    }
}

class HBPictureViewCell: UICollectionViewCell {

    var viewModel: HBStatusPictureViewModel? {
        didSet {
            picImgView.sd_setImageWithURL(viewModel?.picURL)
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
        contentView.addSubview(picImgView)
        picImgView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }

    // MARK: - lazy load
    private lazy var picImgView: UIImageView = UIImageView()
}
