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

typealias RemoteClourse = (_ status : NetworkActionStatus ,_ json : JSON? ) -> Void

class Remote{
    
    /**
     POST 请求
     
     - parameter urlString:  请求地址
     - parameter parameters: 参数
     - parameter callback:   @see RemoteClourse
     */
    class func post(url urlString:String, parameters:JSONDictionary? = nil ,callback:@escaping RemoteClourse){
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON {
//             println("response:\($0)")
            self.handleResponse($0, callback: callback)
        }
    }
    
    /**
     GET 请求
     
     - parameter urlString:  请求地址
     - parameter parameters: 参数
     - parameter callback:   @see RemoteClourse
     */
    class func get(url urlString:String ,parameters:JSONDictionary? = nil, callback:@escaping RemoteClourse){

        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON {
             self.handleResponse($0, callback: callback)
        }
    }
    
    //MARK: - private method
    fileprivate class func handleResponse(_ response:DataResponse<Any>, callback : @escaping RemoteClourse){
        Async.background{
            
            guard let resp = response.response else{
                if let error = response.result.error{
                    Async.main{  callback(.networkFailure(message: error.localizedDescription), nil) }
                }
                return 
            }
            
            if resp.statusCode != 200{
                Async.main{  callback(.networkFailure(message: "网络似乎出了点问题~"), nil) }
                return
            }
            
            guard let value = response.result.value else {  return }
            
            let json = JSON(value)
            
            let status = json["status"].intValue
            let msg = json["mess"].string
            let data = json["data"]
            
            if status == 200{
                Async.main{ callback (.success(message: msg ?? ""),data) }
            }else if status == 202 {
                Async.main{ callback (.userNeedLogin,nil) }
            }else if status == 203 {
                Async.main{ callback (.userFailure(message:"请求服务器发生错误~"), nil ) }
            }else{
                Async.main{ callback (.userFailure(message: msg ?? "服务器似乎出了点问题~"),data) }
            }
        }
    }
}
