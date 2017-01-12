//
//  ChatController.swift
//  MoYu
//
//  Created by lxb on 2017/1/10.
//  Copyright © 2017年 Chris. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class PeopleChatController: JSQMessagesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mo_navigationBar(title: receiveName)
        
        setupView()
        
//        let conversation = EMClient.shared().chatManager.getConversation("", type: EMConversationTypeChat, createIfNotExist: true)
        
        EMClient.shared().chatManager.add(self)
    }
    
    deinit {
        EMClient.shared().chatManager.remove(self)
    }
    
    
    //MARK: - private mothods
    private func setupView(){
        
        inputToolbar.contentView.textView.placeHolder = "打个招呼吧~"
        
        collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height:kJSQMessagesCollectionViewAvatarSizeDefault )
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height:kJSQMessagesCollectionViewAvatarSizeDefault )
        
        collectionView?.collectionViewLayout.springinessEnabled = false
        
        automaticallyScrollsToMostRecentMessage = true
        
        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.jsq_defaultTypingIndicator(), style: .plain, target: self, action: #selector(receiveMessagePressed))
    }
    
    func receiveMessagePressed(_ sender: UIBarButtonItem) {
        
        /**
         *  Show the typing indicator to be shown
         */
        self.showTypingIndicator = !self.showTypingIndicator
        
        /**
         *  Scroll to actually view the indicator
         */
        self.scrollToBottom(animated: true)
        
        /**
         *  Copy last sent message, this will be the new "received" message
         */
        
        guard let model = chatFriend else{ return }
        
        let newMessage = JSQMessage(senderId: model.phonenum, displayName: model.nickname, text: "Nice to meet you..")

        /**
         *  Upon receiving a message, you should:
         *
         *  1. Play sound (optional)
         *  2. Add new JSQMessageData object to your data source
         *  3. Call `finishReceivingMessage`
         */
        
        self.messages.append(newMessage!)
        self.finishReceivingMessage(animated: true)
    }
    
    
    // MARK: JSQMessagesViewController method overrides
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        /**
         *  Sending a message. Your implementation of this method should do *at least* the following:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishSendingMessage`
         */
//        
//        println("send message, senderID is \(senderId), name is \(senderDisplayName), text is \(text)")
//        
//        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
//        self.messages.append(message!)
//        self.finishSendingMessage(animated: true)
        sendMessage(text: text, senderId: senderId, senderDisplayName: senderDisplayName, date: date)
    }
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        self.inputToolbar.contentView!.textView!.resignFirstResponder()
        
        
        println("did pressAccessoryButton")
    }
    
    fileprivate func sendMessage(text:String,senderId: String, senderDisplayName: String, date: Date){

        let body = EMTextMessageBody(text: text)
        guard let conversationId = conversation?.conversationId, let recvId = chatFriend?.phonenum else{ return }
        let message = EMMessage(conversationID: conversationId, from: senderId, to: recvId, body: body, ext: nil)
        message?.chatType = EMChatTypeChat
        message?.localTime = Int64(Date().timeIntervalSince1970)
        
        EMClient.shared().chatManager.send(message, progress: { progress in
            
        }, completion: { [weak self] (message, error) in
            
            if error == nil{
                let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
                self?.messages.append(message!)
                self?.finishSendingMessage(animated: true)
            }else{
            
                println(error)
            }
        })
    }
    
    
    //MARK: JSQMessages CollectionView DataSource
    
    override var senderId: String?{
        get{
            return UserManager.sharedInstance.user.phonenum
        }
        set(newValue){
            println("set sender id, but undefined")
        }
    }
    
    
    override var senderDisplayName: String?{
        get{
            return UserManager.sharedInstance.user.nickname
        }
        set(newValue){
            println("set sender DisplayName, but undefined")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        
        if let messageId = messages[indexPath.item].senderId,
            let senderId = self.senderId, messageId == senderId {
            return outgoingBubble
        }
        return incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        if let messageId = messages[indexPath.item].senderId,
            let senderId = self.senderId, messageId == senderId {
            return senderAvatar
        }
        return recvAvatar
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        
        if indexPath.item == 0{
            let message = self.messages[indexPath.item]
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }else{
            let message1 = messages[indexPath.item]
            let message2 = messages[indexPath.item - 1]
            if message1.date.timeIntervalSince(message2.date!) > 60{
                return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message1.date)
            }
        }
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForCellTopLabelAt indexPath: IndexPath) -> CGFloat {

        if indexPath.item == 0{
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }else{
            let message1 = messages[indexPath.item]
            let message2 = messages[indexPath.item - 1]
            if message1.date.timeIntervalSince(message2.date!) > 60{
                return kJSQMessagesCollectionViewCellLabelHeightDefault
            }
        }
        return 0.0
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {

        return 0
    }
    
    
    //MARK: - var & let
    var chatFriend:AroundPeopleModel?
    
    var messages = [JSQMessage]()
    
    fileprivate lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.lightGray)
    }()
    
    fileprivate lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    fileprivate var senderAvatar:JSQMessagesAvatarImage = {
        let imageView = UIImageView()
        imageView.mo_loadImage(UserManager.sharedInstance.user.avatorUrl)
        return JSQMessagesAvatarImageFactory.avatarImage(withPlaceholder: imageView.image, diameter: 34)
    }()
    
    fileprivate lazy var recvAvatar:JSQMessagesAvatarImage = {
        let imageView = UIImageView()
        imageView.mo_loadImage(self.chatFriend?.avator ?? "")
        return JSQMessagesAvatarImageFactory.avatarImage(withPlaceholder: imageView.image, diameter: 34)
    }()
    
    fileprivate var receiveName:String{
        
        if let nickname = chatFriend?.nickname{
            return nickname
        }else{
            return chatFriend?.phonenum ?? ""
        }
    }
    
    fileprivate lazy var conversation:EMConversation? = {
        
        return EMClient.shared().chatManager.getConversation(self.chatFriend?.phonenum ?? "", type: EMConversationTypeChat, createIfNotExist: true)
        
    }()
}


// MARK: - EMChatManagerDelegate
extension PeopleChatController:EMChatManagerDelegate{
    
    fileprivate func covertEMMessage(message:EMMessage)->JSQMessage?{
        
        guard let conversationId = self.conversation?.conversationId,
            let name = message.from,
            let body = message.body else{
            return nil
        }
        
        switch body.type {
        case EMMessageBodyTypeText:
            if let body = body as? EMTextMessageBody,
                let text = body.text {
                
                let date = Date.init(timeIntervalSinceNow: TimeInterval(message.localTime))
                return JSQMessage(senderId: conversationId, senderDisplayName: name, date: date, text:text )
            }
            
        default: break
        }
        return nil
    }
    
    
    /// 接收一条及以上的非cmd消息
    ///
    /// - Parameter aMessages: 消息
    func messagesDidReceive(_ aMessages: [Any]!) {
        
        messages += aMessages.flatMap{ $0 as? EMMessage }.flatMap( covertEMMessage(message:) )
        
        scrollToBottom(animated: true)
        
        finishReceivingMessage(animated: true)
    }
    
    
    /// 接收一条及以上的cmd
    ///
    /// - Parameter aCmdMessages: 消息
    func cmdMessagesDidReceive(_ aCmdMessages: [Any]!) {
        
    }
    
}
