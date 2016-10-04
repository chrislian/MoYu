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
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


final class MoAlert {

    class func alert(title: String, message: String?, dismissTitle: String, inViewController: UIViewController?, dismissAction: (() -> Void)?) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            alertController.addAction(action)

            inViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    class func alertSorry(message: String?, inViewController : UIViewController?, dismissAction: (() -> Void)? = nil) {
        alert(title: "抱歉", message: message, dismissTitle: "好的", inViewController: inViewController, dismissAction: dismissAction)
    }


    class func textInput(title: String, placeholder: String?, oldText: String?, dismissTitle: String, inViewController: UIViewController?, finishedAction: ((_ text: String) -> Void)?) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)

            alertController.addTextField { textField in
                textField.placeholder = placeholder
                textField.text = oldText
            }

            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action in
                if let finishedAction = finishedAction {
                    if let textField = alertController.textFields?.first, let text = textField.text {
                        finishedAction(text)
                    }
                }
            }
            alertController.addAction(action)

            inViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    static weak var confirmAlertAction: UIAlertAction?
    
    class func textInput(title: String, message: String?, placeholder: String?, oldText: String?, confirmTitle: String, cancelTitle: String, inViewController: UIViewController?, confirmAction: ((_ text: String) -> Void)?, cancelAction: (() -> Void)?) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alertController.addTextField { textField in
                textField.placeholder = placeholder
                textField.text = oldText
                textField.addTarget(self, action: #selector(MoAlert.handleTextFieldTextDidChangeNotification(_:)), for: .editingChanged)
            }

            let _cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                cancelAction?()
            }
            
            alertController.addAction(_cancelAction)
            
            let _confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { action in
                if let textField = alertController.textFields?.first, let text = textField.text {
                    
                    confirmAction?(text)
                }
            }
            _confirmAction.isEnabled = false
            self.confirmAlertAction = _confirmAction
            
            alertController.addAction(_confirmAction)

            inViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    @objc class func handleTextFieldTextDidChangeNotification(_ sender: UITextField) {

        MoAlert.confirmAlertAction?.isEnabled = sender.text?.utf16.count >= 1
    }
    
    class func confirmOrCancel(title: String, message: String, confirmTitle: String, cancelTitle: String, inViewController viewController: UIViewController?, confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                cancelAction()
            }
            alertController.addAction(cancelAction)

            let confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { action in
                confirmAction()
            }
            alertController.addAction(confirmAction)

            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIViewController {

    fileprivate func showProposeAlert(message:String){
    
        Async.main{
            
            MoAlert.confirmOrCancel(title: "抱歉", message: message, confirmTitle: "现在就改", cancelTitle: "了解", inViewController: self, confirmAction: {
                    UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
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

    func showProposeMessageIfNeedForContactsAndTryPropose(_ propose: @escaping Propose) {

        if PrivateResource.contacts.isNotDeterminedAuthorization {

            DispatchQueue.main.async {

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

