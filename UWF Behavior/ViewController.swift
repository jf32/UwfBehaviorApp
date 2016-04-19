//
//  ViewController.swift
//  UWF Behavior
//
//  Created by James Frazier on 3/31/16.
//  Copyright © 2016 UWF Students. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let courseIds: [Int] = []
        let thefinaltitles: [Int: String] = [:]
        let courseSet = GetCourses(titles: thefinaltitles, courseIDs: courseIds)
        var count = 1
        courseSet.readJsonCourses()
        var theTitles = courseSet.titlesArray
        let numCourses = courseSet.returnNumCourses()
        print("There are \(numCourses) courses that were found.\n")
        theTitles = theTitles.sort()
        for i in theTitles{
            print("\(count). \(i)")
            ++count
        }
        
        if (count == courseSet.counter)
        {
            print("Success")
        }
        
            //if let titles1 = (titles as String){
            //print("\(titles1)\n")
            //}
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    /*
     *
     *

    func readJsonCourses(object: NSDictionary){ //-> NSDictionary{
        var x = 0
        //var newDict: NSDictionary
        //newDict.setValuesForKeysWithDictionary(setValuesForKeysWithDictionary(""))
        //newDict[0] = NSDictionary(contentsOfFile: "Begin")
        if let status = object["status"] as? String{
            if status == "ok"{
                for dict in object{
                    //print(dict.1)
                    if let dict1 = (dict.1 as?  NSDictionary){
                        
                        print("\(x + 1). ")
                        //newDict = dict1["title"]! as! NSDictionary
                        print(dict1["title"]!)
                        print("\n")
                        
                        ++x
                        //newDict.setValue(value: dict1["title"], forKey: String(x))
                    }
                    
                }
            }
        }
        
    }
    
    /* prepareJson
     *  Pass in an integer to this function to get the
     *  desired information. Will enumerate when finished.
     */
    func prepareJson(x: Int) -> Void{
        let url = NSBundle.mainBundle().URLForResource("getCourses", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        do {
            let d1: NSDictionary
            d1 = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            switch (x){
                case 0:
                    readJsonCourses(d1)
                    break
                default:
                    print("Error with switch")
            }
        }catch{
            print("Error")
        }
    }
    
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
    func jsonToDictionary(data: AnyObject?) -> NSDictionary?{
        do {
            let d1 = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .AllowFragments) as! NSDictionary
            return d1
        } catch{
            print("Error")
            return nil
        }
        
    }
*/
/*
    func testOne(){
    let url = NSBundle.mainBundle().URLForResource("getCourses", withExtension: "json") // this will be commented out
    let data = NSData(contentsOfURL: url!) // this will be commented out
    
    }
*/
    //var neOb: AnyObject
    //neOb.dynamicType
    //do{
    //    let json = try SerializableData.init()
    //}catch{
    //    print("Error")
    //}
    
    //serialJSON.dynamicType.init(anyData: neOb)

}

*/