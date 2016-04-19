//
//  Test.swift
//  UWF Behavior
//
//  Created by Andrew Havard on 4/15/16.
//  Copyright © 2016 UWF Students. All rights reserved.
//

import Foundation
import UIKit
/*
let getCoursesURL = "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/"
let path = NSBundle.mainBundle().bundlePath as NSString // it needs be NSString, Swift String doesn't have stringByAppendingPathComponent method
let data = NSData(path.stringByAppendingPathComponent("data.json"))

public class Test: SerializedDataRetrievable{
    public required convenience init?(serializedString json: String) {
        self.init(data: try? SerializableData(jsonString: json))
    }
    public required convenience init?(serializedData jsonData: NSData) {
        self.init(data: try? SerializableData(jsonData: jsonData))
    }
}

func parseJson(){
    //let requestURL: NSURL = NSURL(string: "http://www.learnswiftonline.com/Samples/subway.json")!
    let requestURL: NSURL = NSURL(string: "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/")!
    let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithRequest(urlRequest) {
        (data, response, error) -> Void in
    
        let httpResponse = response as! NSHTTPURLResponse
        let statusCode = httpResponse.statusCode
    
        if (statusCode == 200) {
            //let nums = [0: 1000]
            //var number = 1
            do{
            
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                if let status = json["status"] as? String{
                    if status == "ok"{
                        if let courseindicies = json["0"] as? [String: AnyObject]{
                            if courseindicies == "0"{
                            if let courses = json["course"] as? [String: AnyObject]{
                                print(courses)
                            }
                            if let title = json["title"] as? String{
                                print(title)
                            }
                            }
                        }
                    }
                }
            }

            
                
            /*
                if let stations = json["stations"] as? [[String: AnyObject]] {
                
                    for station in stations {
                    
                        if let name = station["stationName"] as? String {
                        
                            if let year = station["buildYear"] as? String {
                                NSLog("%@ (Built %@)",name,year)
                            }
                        
                        }
                    }
                
                }
                    //                        if let course = json["course"] as? [String: AnyObject]{
                    if let courseid = json["ID"] as? Int{
                    print("Course 0:\nID: \(courseid)")
                    }}
                    }
            */
            catch {
                print("Error with Json: \(error)")
            
            }
        
        }
    
    }
    task.resume()
}
//self.resume()
*/
