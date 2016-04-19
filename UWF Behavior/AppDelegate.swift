//
//  AppDelegate.swift
//  UWF Behavior
//
//  Created by James Frazier on 3/31/16. 
//  Copyright © 2016 UWF Students. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //testJson()
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
    
    // Convert from JSON to nsdata
/*
    func jsonToNSData(json: AnyObject) -> NSData?{
        do {
            return try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
*/
/*
    func testJson(){
        let path = NSBundle.mainBundle().bundlePath as NSString
        let jsonPath = path.stringByAppendingPathComponent("getCourses.json")
        //if let data:NSData = JSON(dic) {
        //    NSLog(NSString(data: data, encoding: NSUTF8StringEncoding)! as String)
        // }
        let data = jsonToNSData(jsonPath)
        var json: [String: AnyObject]!
        //let data = NSData()
        // 1
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
        } catch {
            print(error)
            //task.resume()
        }
        
        // 2
        guard let toplevel = TopLevel(json: json) else {
            print("Error initializing object")
            return
        }
        
        // 3
        guard let firstItem = toplevel.status else {
            print("No such item")
            return
        }
        
        // 4
        print(firstItem)
    }

*/
}

