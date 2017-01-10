//
//  ChatController.swift
//  MoYu
//
//  Created by lxb on 2017/1/10.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class PeopleChatController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let nickname = chatFriend?.nickname{
            
            mo_navigationBar(title: nickname)
        }else {
            mo_navigationBar(title: chatFriend?.phonenum ?? "")
        }
    }

    var chatFriend:AroundPeopleModel?
}
