//
//  Remote.swift
//  MoYu
//
//  Created by Chris on 16/7/7.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON
import Async

typealias RemoteClourse = (status : NetworkActionStatus ,json : JSON? ) -> Void

class Remote{
    
    /**
     POST 请求
     
     - parameter urlString:  请求地址
     - parameter parameters: 参数
     - parameter callback:   @see RemoteClourse
     */
    class func post(url urlString:String, parameters:[String:AnyObject]? = nil ,callback:RemoteClourse){
        
        Alamofire.request(.POST, urlString, parameters: parameters).responseJSON {
            
            println("response:\($0)")
            
            self.handleResponse($0, callback: callback)
        }
    }
    
    /**
     GET 请求
     
     - parameter urlString:  请求地址
     - parameter parameters: 参数
     - parameter callback:   @see RemoteClourse
     */
    class func get(url urlString:String ,parameters:[String:AnyObject]? = nil, callback:RemoteClourse){
        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON {
            
            self.handleResponse($0, callback: callback)
        }
    }
    
    //MARK: - private method
    private class func handleResponse(response:Response<AnyObject, NSError>, callback : RemoteClourse){
        Async.background{
            
            guard let resp = response.response else{
                if let error = response.result.error {
                    
                    let message = error.userInfo["NSLocalizedDescription"] as? String

                    Async.main{  callback(status: .networkFailure(message: message ?? "网络似乎出了点问题..."), json: nil) }
                }
                return
            }
            
            if resp.statusCode != 200{
                Async.main{  callback(status: .networkFailure(message: "网络似乎出了点问题..."), json: nil) }
                return
            }
            
            guard let value = response.result.value else {  return }
            
            let json = JSON(value)
            
            let status = json["status"].intValue
            let msg = json["mess"].string
            let data = json["data"]
            
            if status == 200{
                Async.main{ callback (status:.success(message: msg ?? ""),json: data) }
            }else{
                Async.main{ callback (status:.userFailure(message: msg ?? "网络似乎出了点问题..."),json: data) }
            }
        }
    }
}