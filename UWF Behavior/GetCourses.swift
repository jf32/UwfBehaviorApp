//
//  GetCourses.swift
//  UWF Behavior
//
//  Created by Andrew Havard on 4/7/16.
//  Copyright © 2016 UWF Students. All rights reserved.
//

import Foundation
import UIKit

//let getCoursesURL = "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/"

enum returnType{
    case IntArray([Int])
    case DictionaryVal(NSDictionary)
    case StringArrayInt([String], Int)
    case StringVals([String])
    case IntegerVal(Int)
    case NullVal
}


public class GetCourses {
    
    let jsonLocation: String = "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/"
    let titles: NSDictionary
    var titlesArray: [String]
    var courseIDs : [String]
    var counter: Int
    var finalDict: [String: String]
    
    //MARK: Initialize the GetCourses class
    
    required public init(titles: NSDictionary, courseIDs: [Int]){
        self.counter = 0
        self.courseIDs = []
        self.titles = titles
        self.titlesArray = []
        self.finalDict = [:]
    }
    
    /* readJsonCourses
     *  -parameters: NSDicionary of json data with courses
     *  -return value: Array of Courses as Strings, and the total nubmer of courses 
     *                  as a returnType enum (StringArrayInt or NullVal for fail)
     *                  also mutates class fields, and sorts the titlesArray after
     *                  it succeeds in getting all titles.
     *
     *  Note: Don't really need to return since we are just mutating class fields, but
     *          I might change this, so I'm keeping it since it doesn't affect execution
     */
    func readJsonCourses() -> returnType{
        
        // Always call prepareJson to get the dictionary of the json file
        let object = prepareJson()
        
        // Set the counter to 0 so we can count the number of titles
        counter = 0
        var returnArray = [String]()
        if let status = object["status"] as? String{
        
        // Make sure the json file indicates the status is "ok"
            if status == "ok"{
                for thetitle in object{
                    if let thetitle1 = (thetitle.1 as? NSDictionary){ //object["title"] as? String{
                        
                        // One of these can be omitted, depending on how we want
                        // the final program to work and what would be best
                        // returnArray and self.titlesArray should be the same
                        returnArray.append(String(thetitle1["title"]!))
                        self.titlesArray.append(String(thetitle1["title"]!))
                        ++counter
                        }
                    }
                for vidIds in object{
                    if let vidIds1 = (vidIds.1 as? NSDictionary){
                        self.courseIDs.append(String(vidIds1["video_id"]!))
                    }
                }
            }
            else{
                return .NullVal
            }
        }
        
        // Make the dictionary have all titles match
        //  with their respective 'video_id'
        createIDtitleDict()
        
        // Sort the return array and the class value 'titlesArray'
        returnArray = returnArray.sort()
        self.titlesArray = returnArray
        return .StringArrayInt(returnArray, ++counter)
    }
    
    private func createIDtitleDict(){
        var counter2 = 0
        for id in self.courseIDs{
            self.finalDict.updateValue(id, forKey: titlesArray[counter2])
            print("\(counter2 + 1). \(self.titlesArray[counter2])\n\tVideo_id: \(id)")
            ++counter2
        }
    }
    
    /* prepareJson
    *  Helper function that returns an NSDictionary for the getCourses json
    *   file.
    *   -return type: NSDictionary of getCourses.json
    */
    func prepareJson()-> NSDictionary{
        //let requestURL: NSURL = NSURL(string: self.jsonLocation)!
        //let data = NSData(contentsOfURL: requestURL)
        let url = NSBundle.mainBundle().URLForResource("getCourses", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        let dict = NSDictionary()
        do {
            let d1: NSDictionary
            d1 = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            return d1
        }catch{
            print("Error in prepareJson (outside switch)")
            return dict
        }
    }

    func returnNumCourses() -> Int{
        return self.counter
    }
    
    func returnTitlesArray() -> [String]?{
        return self.titlesArray
    }
    
    func returnDictWithTitlesAndIDs() -> [String: String]{
        return self.finalDict
    }
    
    /*
    func test2(){
    let object: NSDictionary
    let requestURL: NSURL = NSURL(string: "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/")!
    let data = NSData(contentsOfURL: requestURL)
    }
    */
/*
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
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    if let status = json["status"] as? String{
                        if status == "ok"{
                            for thetitle in task{
                                if let thetitle1 = (thetitle.1 as? NSDictionary){ //object["title"] as? String{
                                    
                                    // One of these can be omitted, depending on how we want
                                    // the final program to work and what would be best
                                    // returnArray and self.titlesArray should be the same
                                    returnArray.append(String(thetitle1["title"]!))
                                    self.titlesArray.append(String(thetitle1["title"]!))
                                    
                                    ++counter
                                }
                            }
                        }
                    }
                }
                catch {
                    print("Error with Json: \(error)")
                    
                }
                
            }
            
        }
        task.resume()
    }
*/
    //func isNil(dict: NSDictionary) -> returnType{
    //    if (dict.)
    //}
}
    /* coursesToNSDict
     *  primary function to return the getCourses.json
     *  file (with the use of above helper functions)
     *  as a Dictionary of the courses
     */
    /*
    func coursesToNSDict() -> NSDictionary{
        
    }
    
    

}
*/




/*
    func testTwoThousand() -> Void{
        let urlPath: String = "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/"
        /*var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.backgroundSessionConfiguration(urlPath), delegate: nil, delegateQueue: DISPATCH_QUEUE_PRIORITY_DEFAULT)
        */
        let requestURL: NSURL = NSURL(string: urlPath)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200){
                
            }
        }
    }
    
    func testOne(){
        let url = NSBundle.mainBundle().URLForResource("Courses", withExtension: "json") // this will be commented out
        let data = NSData(contentsOfURL: url!) // this will be commented out

    }
    
    func readJSONObject(object: NSDictionary) {
        if let status = object["status"] as? String{
            if status == "ok"{
                for dict in object{
                    print(dict.1)
                    if let dict1 = (dict.1 as?  NSDictionary)
                    {
                        dict1["title"]
                    }
                }
            }
        }
    }
*/
/*
    func jsonToNSData(json: AnyObject) -> NSData?{
        do {
            return try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
}
*/
/*
    internal func jsonToNSDict() -> Void{
        let url = NSBundle.mainBundle().URLForResource("getCourses", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        do {
            let d1: NSDictionary
            d1 = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            readJSONObject(d1)
        }catch{
            print("Error")
        }
    }
    
    func jsonToDictionary(data: AnyObject?) -> NSDictionary?{
        do {
            let d1 = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: .AllowFragments) as! NSDictionary
            return d1
        } catch{
            print("Error")
            return nil
        }
        
    }
}
    /*
    func getAllCourses() -> NSDictionary{
        let object: NSDictionary
        let requestURL: NSURL = NSURL(string: "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let data = NSData(contentsOfURL: urlRequest)

        //let data = NSData(contentsOfURL: url!)
        do{
            if let status = object["status"] as? String{
                if status == "ok"{
                    for dict in object{
                        // print(dict.1)
                        if let dict1 =  (dict.1 as?  NSDictionary)
                        {
                            dict1["title"]
                            print(String(dict1["title"]!))
                        }

                    }


                }
    */
/*
    //ParseJSON.getTopAppsDataFromFileWithSuccess { (data) -> Void in
    // or
    //DataManager.getTopAppsDataFromItunesWithSuccess { (data) -> Void in
    var json: [String: AnyObject]!
    
    // 1
    do {
        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
    } catch {
        print(error)
        XCPlaygroundPage.currentPage.finishExecution()
    }
    
    // 2
    guard let topApps = TopApps(json: json) else {
        print("Error initializing object")
        XCPlaygroundPage.currentPage.finishExecution()
    }
    
    // 3
    guard let firstItem = topApps.feed?.entries?.first else {
        print("No such item")
        XCPlaygroundPage.currentPage.finishExecution()
    }
    
    // 4
    print(firstItem)
    
   // XCPlaygroundPage.currentPage.finishExecution()
    
}


let getCoursesURL = "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/"

public struct TopLevel: Parseable {
    
    let status: String?
    let courses: Int?
    
    
    // MARK: - Deserialization
    
    public init?(json: JSON) {
        self.status = "status" <~~ json
        self.courses = "0" <~~ json
    }
    


public struct Courses: Parseable {
    
    public let entries: TopLevel?
    
    public init?(json: JSON) {
        entries = "course" <~~ json
    }
    
}

public struct CourseInfo : Parseable {

    let id: Int?
    let status: String?
    let extended: Bool?
    let author: String?
    
    public init?(json: JSON){
        self.id = "ID" <~~ json
        self.status = "status" <~~ json
        self.extended = "extended" <~~ json
        self.author = "author" <~~ json
    }
}
}


public struct TopLevel: Parseable {
    
    // 1
    public let status: Status?
    public let theStatus: String
    
    // 2
    public init?(json: JSON) {
        
        guard let status: JSON = "status" <~~ container
        theStatus: JSON = "label" <~~id
        else{ return nil}
        //link: status = "status" <~~id
    }
}

public struct Status: Parseable {
    
    public let entries: [App]?
    
    public init?(json: JSON) {
        entries = "entry" <~~ json
    }
    
}

public struct App: Parseable {
    
    // 1
    public let name: String
    public let link: String
    
    public init?(json: JSON) {
        // 2
        guard let container: JSON = "im:name" <~~ json,
            let id: JSON = "id" <~~ json
            else { return nil }
        
        guard let name: String = "label" <~~ container,
            link: String = "label" <~~ id
            else { return nil }
        
        self.name = name
        self.link = link
        print("\nStuff: \(self.link) and \(self.name)\n\n")
    }
    
}
*/
*/
