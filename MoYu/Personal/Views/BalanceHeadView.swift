//
//  BalanceHeadView.swift
//  MoYu
//
//  Created by Chris on 16/7/26.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class BalanceHeadView: UIView {

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc fileprivate func withdrawButtonClicked(_ button:UIButton){
        println("提现")
    }
    
    fileprivate func layout(){
    
        //top
        self.addSubview(cycleView)
        cycleView.snp.makeConstraints { (make) in
            make.center.equalTo(self )
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        cycleView.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.cycleView)
        }
        
        cycleView.addSubview(balanceTitleLabel)
        balanceTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(balanceLabel)
            make.bottom.equalTo(balanceLabel.snp.top)
        }
        
        //bottom
        self.addSubview(consumeDetailLabel)
        consumeDetailLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
        
        self.addSubview(leftLineView)
        leftLineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(16)
            make.centerY.equalTo(consumeDetailLabel)
            make.right.equalTo(consumeDetailLabel.snp.left).offset(-10)
            make.height.equalTo(0.5)
        }
        
        self.addSubview(rightLineView)
        rightLineView.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-16)
            make.centerY.equalTo(consumeDetailLabel)
            make.left.equalTo(consumeDetailLabel.snp.right).offset(10)
            make.height.equalTo(leftLineView)
        }
        
        //middle
        self.addSubview(withdrawView)
        withdrawView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(consumeDetailLabel).offset(-30)
            make.top.greaterThanOrEqualTo(cycleView).offset(20)
        }
        
        withdrawView.addSubview(withdrawImageView)
        withdrawImageView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(withdrawView)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        withdrawView.addSubview(withdrawLabel)
        withdrawLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(withdrawView)
            make.height.equalTo(withdrawImageView)
            make.left.equalTo(withdrawImageView.snp.right).offset(5)
        }
    }
    
    //MARK: - var & let
    let cycleView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mo_lightYellow
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    let balanceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.mo_boldFont(.biggest)
        label.textColor = UIColor.mo_silver
        label.textAlignment = .center
        label.text = "8800.00"
        return label
        
    }()
    
    let balanceTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.mo_font(.smaller)
        label.textColor = UIColor.mo_silver
        label.textAlignment = .center
        label.text = "余额(元)"
        return label
    }()
    
    let withdrawView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.mo_lightBlack.cgColor
        view.layer.borderWidth = 0.8
        return view
    }()
    
    fileprivate let withdrawImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defalutHead")
        return imageView
    }()
    
    fileprivate let withdrawLabel:UILabel = {
        let label = UILabel()
        label.text = "提现 "
        label.textColor = UIColor.mo_lightBlack
        label.font = UIFont.mo_font()
        return label
    }()
    
    fileprivate lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: UIControlState())
        button.addTarget(self, action: #selector(BalanceHeadView.withdrawButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    
    fileprivate let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mo_silver
        return view
    }()
    fileprivate let rightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mo_silver
        return view
    }()
    
    fileprivate let consumeDetailLabel:UILabel = {
        let label = UILabel()
        label.text = "余额明细"
        label.textColor = UIColor.mo_silver
        label.font = UIFont.mo_font(.smaller)
        return label
    }()
}
