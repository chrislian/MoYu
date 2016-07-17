//
//  AppDelegate.swift
//  MoYu
//
//  Created by Chris on 16/4/3.
//  Copyright © 2016年 Chris. All rights reserved.
//
////                          _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

import UIKit
import REFrostedViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var mapManager = BMKMapManager()

    //MARK: - AppDelegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if !mapManager.start("r9LH3rGsee4Iks2ogmnC9jMfSqWEdnIR", generalDelegate: self){
            println("Manager start failed")
        }
        //self.turnToHomeViewController()
        if let siginInVc = SB.SignIn.Vc.signIn() {
            self.window?.rootViewController = siginInVc
        }else{
            self.turnToHomeViewController()
        }
        
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: - turn to home view controller
    
    func turnToHomeViewController(){
        
        guard let homeVc = SB.Main.Vc.home(),
            let leftMenuVc = SB.Personal.Vc.leftMenu() else{
                return
        }
        let frostedVc = REFrostedViewController(contentViewController: homeVc, menuViewController: leftMenuVc)
        frostedVc.direction = .Left
        frostedVc.liveBlurBackgroundStyle = .Light
        frostedVc.liveBlur = true
        self.window?.rootViewController = frostedVc
    }
}

//MARK: - Baidu GeneralDelegate
extension AppDelegate:BMKGeneralDelegate{
    
    func onGetNetworkState(iError: Int32) {
        if iError != 0{
            println("联网失败，错误码：Error\(iError)")
        }
    }
    
    func onGetPermissionState(iError: Int32) {
        if iError != 0{
            println("授权失败，错误码：Error\(iError)")
        }
    }
}

