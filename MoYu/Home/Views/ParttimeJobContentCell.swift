//
//  ParttimeJobContentCell.swift
//  MoYu
//
//  Created by lxb on 2016/12/9.
//  Copyright © 2016年 Chris. All rights reserved.
//

import UIKit

class ParttimeJobContentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.textColor = UIColor.mo_lightBlack
    }

    class func cell(tableView:UITableView)->ParttimeJobContentCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SB.Main.Cell.parttimeContent) as? ParttimeJobContentCell else{
            return ParttimeJobContentCell(style: .default, reuseIdentifier:  SB.Main.Cell.parttimeContent)
        }
        return cell
    }
    
    @IBOutlet weak var textView: UITextView!
}
