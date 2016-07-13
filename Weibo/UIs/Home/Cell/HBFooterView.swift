//
//  HBToolBarView.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

class HBFooterView: UIView {

    var viewModel: HBStatusCellViewModel? {
        didSet {
            repostBtn.setTitle(viewModel?.repostCount, forState: .Normal)
            commentBtn.setTitle(viewModel?.commentCount, forState: .Normal)
            attitudeBtn.setTitle(viewModel?.attitudeCount, forState: .Normal)
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
        addSubview(repostBtn)
        addSubview(commentBtn)
        addSubview(attitudeBtn)

        addSubview(line1)
        addSubview(line2)

        // 三个按钮的平铺, 重要的是`宽度`平铺. 需要设置2个按钮的宽度和另外一个按钮的一致
        repostBtn.snp_makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.height.equalTo(30)     // 上下间距有点大, 取固定值
        }
        commentBtn.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(repostBtn)
            make.left.equalTo(repostBtn.snp_right)
            make.right.equalTo(attitudeBtn.snp_left)
            // width
            make.width.equalTo(repostBtn)
        }
        attitudeBtn.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(repostBtn)
            make.right.equalTo(self)
            // width
            make.width.equalTo(repostBtn)
        }

        line1.snp_makeConstraints { (make) in
            make.top.equalTo(repostBtn).offset(5)
            make.bottom.equalTo(repostBtn).offset(-5)
            make.centerX.equalTo(commentBtn.snp_left)
        }
        line2.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(line1)
            make.centerX.equalTo(commentBtn.snp_right)
        }
    }

    // MARK: - lazy load
    private lazy var repostBtn: UIButton = UIButton(title: "转发", titleColor: .darkGrayColor(), font: 14.0, image: "timeline_icon_retweet", bgImageNor: "timeline_card_bottom_background", bgImageHigh: "timeline_card_middle_background_highlighted", tag: 0, target: self, method: "repostBtnClick:")
    private lazy var commentBtn: UIButton = UIButton(title: "评论", titleColor: .darkGrayColor(), font: 14.0, image: "timeline_icon_comment", bgImageNor: "timeline_card_bottom_background", bgImageHigh: "timeline_card_middle_background_highlighted", tag: 0, target: self, method: "commentBtnClick:")
    private lazy var attitudeBtn: UIButton = UIButton(title: "点赞", titleColor: .darkGrayColor(), font: 14.0, image: "timeline_icon_unlike", bgImageNor: "timeline_card_bottom_background", bgImageHigh: "timeline_card_middle_background_highlighted", tag: 0, target: self, method: "attitudeBtnClick:") // 如何解决`CUICatalog: Invalid asset name supplied:`呢? 另外空颜色呢(.clearColor)?

    // 竖向分隔线
    private lazy var line1: UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
    private lazy var line2: UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))

    // btn click
    @objc private func repostBtnClick(btn: UIButton) {
        printLog("repost")
    }
    @objc private func commentBtnClick(btn: UIButton) {
        printLog("comment")
    }
    @objc private func attitudeBtnClick(btn: UIButton) {
        printLog("attitude")
    }
}
