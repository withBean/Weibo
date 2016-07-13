//
//  HBOriginalView.swift
//  Weibo
//
//  Created by Beans on 16/7/13.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

import UIKit

let cellMargin: CGFloat = 10

class HBOriginalView: UIView {

    var originalViewModel: HBStatusCellViewModel? {
        didSet {
            userIcon.sd_setImageWithURL(originalViewModel?.userIcon)
            userName.text = originalViewModel?.userName
            vipIcon.image = originalViewModel?.vipIcon
            verifyIcon.image = originalViewModel?.verifyIcon
            releaseTime.text = originalViewModel?.releaseTime
            releaseSource.text = originalViewModel?.releaseSource
            blogContent.text = originalViewModel?.blogContent
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
        backgroundColor = colorWithHexString("CCFFCC")

        addSubview(userIcon)
        addSubview(userName)
        addSubview(vipIcon)
        addSubview(verifyIcon)
        addSubview(releaseTime)
        addSubview(releaseSource)
        addSubview(blogContent)

        // 圆角
        userIcon.layer.cornerRadius = 20
        userIcon.layer.masksToBounds = true

        userIcon.snp_makeConstraints { (make) in
            make.top.left.equalTo(self).offset(cellMargin)
            make.width.height.equalTo(40)
        }
        userName.snp_makeConstraints { (make) in
            make.top.equalTo(userIcon)
            make.left.equalTo(userIcon.snp_right).offset(cellMargin)
        }
        vipIcon.snp_makeConstraints { (make) in
            make.top.equalTo(userName)
            make.left.equalTo(userName.snp_right).offset(cellMargin)
        }
        verifyIcon.snp_makeConstraints { (make) in
            make.centerX.equalTo(userIcon.snp_right)
            make.centerY.equalTo(userIcon.snp_bottom)
        }
        releaseTime.snp_makeConstraints { (make) in
            make.left.equalTo(userIcon.snp_right).offset(cellMargin)
            make.bottom.equalTo(userIcon)
        }
        releaseSource.snp_makeConstraints { (make) in
            make.left.equalTo(releaseTime.snp_right).offset(cellMargin)
            make.bottom.equalTo(releaseTime)
        }
        blogContent.snp_makeConstraints { (make) in
            make.top.equalTo(userIcon.snp_bottom).offset(cellMargin)
            make.left.equalTo(self).offset(cellMargin)
            make.right.equalTo(self).offset(-cellMargin)
        }
    }

    // MARK: - lazy load
    private lazy var userIcon: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var userName: UILabel = UILabel(text: "用户昵称", fontSize: 18.0, textColor: .orangeColor(), textAlignment: .Left, numberOfLines: 1)
    private lazy var vipIcon: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_expired"))  // vip等级图标
    private lazy var verifyIcon: UIImageView = UIImageView(image: UIImage(named: "avatar_grassroot"))             // 认证图标(草根/大V)
    private lazy var releaseTime: UILabel = UILabel(text: "发布时间", fontSize: 13.0, textColor: .grayColor(), textAlignment: .Left, numberOfLines: 1)
    private lazy var releaseSource: UILabel = UILabel(text: "发布来源", fontSize: 13.0, textColor: .grayColor(), textAlignment: .Left, numberOfLines: 1)
    private lazy var blogContent: UILabel = UILabel(text: "这里是微博正文", fontSize: 16.0, textColor: .blackColor(), textAlignment: .Left, numberOfLines: 0)
}
