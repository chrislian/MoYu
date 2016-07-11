//
//  println
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

func println<T>(message:T,file:String=#file,method:String=#function,line:Int=#line){
    
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")

}