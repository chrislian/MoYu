//
//  MoAlert.swift
//  Mo
//
//  Created by NIX on 15/3/17.
//  Copyright (c) 2015年 Catch Inc. All rights reserved.
//

import UIKit
import Proposer
import Async

final class MoAlert {

    class func alert(title title: String, message: String?, dismissTitle: String, inViewController: UIViewController?, dismissAction: (() -> Void)?) {

        dispatch_async(dispatch_get_main_queue()) {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)

            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .Default) { action in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            alertController.addAction(action)

            inViewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    class func alertSorry(message message: String?, inViewController : UIViewController?, dismissAction: (() -> Void)? = nil) {
        alert(title: "抱歉", message: message, dismissTitle: "好的", inViewController: inViewController, dismissAction: dismissAction)
    }


    class func textInput(title title: String, placeholder: String?, oldText: String?, dismissTitle: String, inViewController: UIViewController?, finishedAction: ((text: String) -> Void)?) {

        dispatch_async(dispatch_get_main_queue()) {

            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)

            alertController.addTextFieldWithConfigurationHandler { textField in
                textField.placeholder = placeholder
                textField.text = oldText
            }

            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .Default) { action in
                if let finishedAction = finishedAction {
                    if let textField = alertController.textFields?.first, text = textField.text {
                        finishedAction(text: text)
                    }
                }
            }
            alertController.addAction(action)

            inViewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    static weak var confirmAlertAction: UIAlertAction?
    
    class func textInput(title title: String, message: String?, placeholder: String?, oldText: String?, confirmTitle: String, cancelTitle: String, inViewController: UIViewController?, confirmAction: ((text: String) -> Void)?, cancelAction: (() -> Void)?) {

        dispatch_async(dispatch_get_main_queue()) {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)

            alertController.addTextFieldWithConfigurationHandler { textField in
                textField.placeholder = placeholder
                textField.text = oldText
                textField.addTarget(self, action: #selector(MoAlert.handleTextFieldTextDidChangeNotification(_:)), forControlEvents: .EditingChanged)
            }

            let _cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .Cancel) { action in
                cancelAction?()
            }
            
            alertController.addAction(_cancelAction)
            
            let _confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .Default) { action in
                if let textField = alertController.textFields?.first, text = textField.text {
                    
                    confirmAction?(text: text)
                }
            }
            _confirmAction.enabled = false
            self.confirmAlertAction = _confirmAction
            
            alertController.addAction(_confirmAction)

            inViewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    @objc class func handleTextFieldTextDidChangeNotification(sender: UITextField) {

        MoAlert.confirmAlertAction?.enabled = sender.text?.utf16.count >= 1
    }
    
    class func confirmOrCancel(title title: String, message: String, confirmTitle: String, cancelTitle: String, inViewController viewController: UIViewController?, confirmAction: () -> Void, cancelAction: () -> Void) {

        dispatch_async(dispatch_get_main_queue()) {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)

            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .Cancel) { action in
                cancelAction()
            }
            alertController.addAction(cancelAction)

            let confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .Default) { action in
                confirmAction()
            }
            alertController.addAction(confirmAction)

            viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

extension UIViewController {

    private func showProposeAlert(message message:String){
    
        Async.main{
            
            MoAlert.confirmOrCancel(title: "抱歉", message: message, confirmTitle: "现在就改", cancelTitle: "了解", inViewController: self, confirmAction: {
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                }, cancelAction: {
            })
        }
    }
    
    func alertCanNotAccessCameraRoll() {

        showProposeAlert(message: "不能访问您的相册！\n但您可以在iOS设置里修改设定。")
    }

    func alertCanNotOpenCamera() {

        showProposeAlert(message: "不能打开您的相机！\n但您可以在iOS设置里修改设定。")
    }

    func alertCanNotAccessMicrophone() {

        showProposeAlert(message: "不能访问您的麦克风！\n但您可以在iOS设置里修改设定。")
    }

    func alertCanNotAccessContacts() {

        showProposeAlert(message: "不能读取您的通讯录！\n但您可以在iOS设置里修改设定。")
    }

    func alertCanNotAccessLocation() {

        showProposeAlert(message: "不能获取您的位置！\n但您可以在iOS设置里修改设定。")
    }

    func showProposeMessageIfNeedForContactsAndTryPropose(propose: Propose) {

        if PrivateResource.Contacts.isNotDeterminedAuthorization {

            dispatch_async(dispatch_get_main_queue()) {

                MoAlert.confirmOrCancel(title: "提示", message: "需要读取您的通讯录来继续此次操作。\n您同意吗？", confirmTitle: "好的", cancelTitle: "以后", inViewController: self, confirmAction: {
                        propose()
                    }, cancelAction: {
                })
            }

        } else {
            propose()
        }
    }
}

