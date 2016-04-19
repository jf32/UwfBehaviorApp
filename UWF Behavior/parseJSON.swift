//
//  parseJSON.swift
//  UWF Behavior
//
//  Created by Andrew Havard on 3/31/16.
//  Copyright © 2016 UWF Students. All rights reserved.
//
//  This file implements a generic way to "parse" JSON into more
//  readily usable types.
//

/*****  README ****************************************
 *  Usage of 'Parser':
 *      The custom operator is this: <~~ (defined below)
 *      For every level of parsing (top level, second, third, so on),
 *      create a swift file with a struct that inherits from 'Parser'.
 *      Or you may use one swift file.
 *      I will show an example in class.
 * custom operators:
 *          <~~json
 *          <~~container
 *          <~~id
 ******************************************************/

import Foundation
import UIKit

/*
let path = "http://atcwebapp.argo.uwf.edu/devbcba/api/mobileapi/getCourses/" as NSString // path for JSON file
let jsonPath = path.stringByAppendingPathComponent("courses.json")
typealias Payload = [String: AnyObject]
var data = NSData()
*/

public typealias JSON = [String : AnyObject]

public struct Parser {
    
    // MARK: - Parsers
    
    // Parse JSON to an optional type
    public static func parse<T>(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> T? {
        return {
            json in
            
            if let value = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? T {
                return value
            }
            
            return nil
        }
    }
    
    // Decode JSON to value type
    public static func parseParseable<T: Parseable>(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> T? {
        return {
            json in
            
            if let subJSON = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? JSON {
                return T(json: subJSON)
            }
            
            return nil
            
        }
    }
    
    // Decode JSON to date type
    public static func parseDate(key: String, dateFormatter: NSDateFormatter, keyPathDelimiter: String = PathDelimiter()) -> JSON -> NSDate? {
        return {
            json in
            
            if let dateString = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? String {
                return dateFormatter.dateFromString(dateString)
            }
            
            return nil
        }
    }
     
    // Decode JSON to enum type
    public static func parseEnum<T: RawRepresentable>(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> T? {
        return {
            json in
            
            if let rawValue = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            
            return nil
        }
    }
    
    // Decode JSON to URL
    public static func parseURL(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> NSURL? {
        return {
            json in
            
            if let urlString = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? String,
                encodedString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
                    return NSURL(string: encodedString)
            }
            
            return nil
        }
    }
    
    // Decode JSON to array
    public static func parseParseableArray<T: Parseable>(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> [T]? {
        return {
            json in
            
            if let jsonArray = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [JSON] {
                var models: [T] = []
                
                for subJSON in jsonArray {
                    if let model = T(json: subJSON) {
                        models.append(model)
                    }
                }
                
                return models
            }
            
            return nil
        }
    }
    
    // Decodes JSON to optional Dictionary Type
    public static func parseParseableDictionary<T:Parseable>(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> [String:T]? {
        return {
            json in
            
            guard let dictionary = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [String : JSON] else {
                return nil
            }
            
            return dictionary.flatMap { (key, value) in
                guard let parsed = T(json: value) else {
                    return nil
                }
                
                return (key, parsed)
            }
        }
    }
    
    // Decode JSON to enum Array Type
    public static func parseEnumArray<T: RawRepresentable>(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> [T]? {
        return {
            json in
            
            if let rawValues = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [T.RawValue] {
                var enumValues: [T] = []
                
                for rawValue in rawValues {
                    if let enumValue = T(rawValue: rawValue) {
                        enumValues.append(enumValue)
                    }
                }
                
                return enumValues
            }
            
            return nil
        }
    }
    
    // Decode JSON to date Array
    public static func parseDateArray(key: String, dateFormatter: NSDateFormatter, keyPathDelimiter: String = PathDelimiter()) -> JSON -> [NSDate]? {
        return {
            json in
            
            if let dateStrings = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [String] {
                var dates: [NSDate] = []
                
                for dateString in dateStrings {
                    if let date = dateFormatter.dateFromString(dateString) {
                        dates.append(date)
                    }
                }
                
                return dates
            }
            
            return nil
        }
    }
    
    // Decode to old date array (not necessary)
    public static func parseDateISO8601Array(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> [NSDate]? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return Parser.parseDateArray(key, dateFormatter: dateFormatter, keyPathDelimiter: keyPathDelimiter)
    }
    
    // Decode JSON to URL array
    public static func parseURLArray(key: String, keyPathDelimiter: String = PathDelimiter()) -> JSON -> [NSURL]? {
        return {
            json in
            
            if let urlStrings = json.valueForKeyPath(key, withDelimiter: keyPathDelimiter) as? [String] {
                var urls: [NSURL] = []
                
                for urlString in urlStrings {
                    if let url = NSURL(string: urlString) {
                        urls.append(url)
                    }
                }
                
                return urls
            }
            
            return nil
        }
    }
    
}

// Custom operator <~~
infix operator <~~ { associativity left precedence 150 }

public func <~~ <T>(key: String, json: JSON) -> T? {
    return Parser.parse(key)(json)
}
/*
 * Operator to make JSON decodable
 */
public func <~~ <T: Parseable>(key: String, json: JSON) -> T? {
    return Parser.parseParseable(key)(json)
}

/*
 * Operator to make JSON enum
 */
public func <~~ <T: RawRepresentable>(key: String, json: JSON) -> T? {
    return Parser.parseEnum(key)(json)
}

/*
 * Operator JSON to NSURL
 */
public func <~~ (key: String, json: JSON) -> NSURL? {
    return Parser.parseURL(key)(json)
}

/*
 * Operator for decoding JSON enum array vals
 */
public func <~~ <T: RawRepresentable>(key: String, json: JSON) -> [T]? {
    return Parser.parseEnumArray(key)(json)
}

/*
 * Operator for JSON to decodable array
 */
public func <~~ <T: Parseable>(key: String, json: JSON) -> [T]? {
    return Parser.parseParseableArray(key)(json)
}

/*
 * JSON to array of URLs
 */
public func <~~ (key: String, json: JSON) -> [NSURL]? {
    return Parser.parseURLArray(key)(json)
}

/*
 * JSON to dictionary of string array
 */
public func <~~ <T: Parseable>(key: String, json: JSON) -> [String : T]? {
    return Parser.parseParseableDictionary(key)(json)
}


public extension Dictionary{
    
    public func valueForKeyPath(keyPath: String, withDelimiter delimiter: String = PathDelimiter()) -> AnyObject? {
        var keys = keyPath.componentsSeparatedByString(delimiter)
        
        guard let first = keys.first as? Key else {
            print("Not able to use string as key on type: \(Key.self)")
            return nil
        }
        
        guard let value = self[first] as? AnyObject else {
            return nil
        }
        
        keys.removeAtIndex(0)
        
        if !keys.isEmpty, let subDict = value as? JSON {
            let rejoined = keys.joinWithSeparator(delimiter)
            
            return subDict.valueForKeyPath(rejoined, withDelimiter: delimiter)
        }
        
        return value
    }
    
    // Initialize elements
    init(elements: [Element]) {
        self.init()
        
        for (key, value) in elements {
            self[key] = value
        }
    }
    
    // Mapping function
    func flatMap<KeyPrime : Hashable, ValuePrime>(transform: (Key, Value) throws -> (KeyPrime, ValuePrime)?) rethrows -> [KeyPrime : ValuePrime] {
        return Dictionary<KeyPrime,ValuePrime>(elements: try flatMap({ (key, value) in
            return try transform(key, value)
        }))
    }
    
    mutating func add(other: Dictionary, delimiter: String = PathDelimiter()) -> () {
        for (key, value) in other {
            if let key = key as? String {
                self.setValue(valueToSet: value, forKeyPath: key, withDelimiter: delimiter)
            } else {
                self.updateValue(value, forKey:key)
            }
        }
    }
    private mutating func setValue(valueToSet val: Any, forKeyPath keyPath: String, withDelimiter delimiter: String = PathDelimiter()) {
        var keys = keyPath.componentsSeparatedByString(delimiter)
        
        guard let first = keys.first as? Key else {
            print("Unable to use string as key on type: \(Key.self)")
            return
        }
        
        keys.removeAtIndex(0)
        
        if keys.isEmpty, let settable = val as? Value {
            self[first] = settable
        } else {
            let rejoined = keys.joinWithSeparator(delimiter)
            var subdict: JSON = [:]
            
            if let sub = self[first] as? JSON {
                subdict = sub
            }
            
            subdict.setValue(valueToSet: val, forKeyPath: rejoined, withDelimiter: delimiter)
            
            if let settable = subdict as? Value {
                self[first] = settable
            } else {
                print("Could not set value: \(subdict) to dictionary of type: \(self.dynamicType)")
            }
        }
        
    }
}

// Returns array of instances from JSON array
//  but only ones that are successfully parsed
public extension Array where Element: Parseable {

    static func fromJSONArray(jsonArray: [JSON]) -> [Element] {
        var models: [Element] = []
        
        for json in jsonArray {
            let model = Element(json: json)
            
            if let model = model {
                models.append(model)
            }
        }
        
        return models
    }
    
}


// Parseable returns a new JSON Parseable object
public protocol Parseable {
    init?(json: JSON)
}

// For nested key paths
public func PathDelimiter() -> String {
    return "."
}

// Returns single JSON dictionary
public func jsonify(array: [JSON?], keyPathDelimiter: String = PathDelimiter()) -> JSON? {
    var json: JSON = [:]
    
    for j in array {
        if(j != nil) {
            json.add(j!, delimiter: keyPathDelimiter)
        }
    }
    
    return json
}


// **********************************************************
// The below can be ignored, mostly garbage code
// that I wrote attempting a solution at parsing JSON.
// I'm leaving it in for my sake in case I need to use any of it.
// **********************************************************

/*
func getData{ (data) -> Void in
    
    var json: Payload!
    
    // 1
    do {
        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Payload
    } catch {
        print(error)
        self.currentPage.finishExecution()
    }
    
    // 2
    guard let feed = json["feed"] as? Payload,
        let apps = feed["entry"] as? [AnyObject],
        let app = apps.first as? Payload
        else { self.currentPage.finishExecution() }
    
    guard let container = app["im:name"] as? Payload,
        let name = container["label"] as? String
        else { XCPlaygroundPage.currentPage.finishExecution() }
    
    guard let id = app["id"] as? Payload,
        let link = id["label"] as? String
        else { XCPlaygroundPage.currentPage.finishExecution() }
    
    // 3
    let entry = App(name: name, link: link)
    print(entry)
    
    currentPage.finishExecution()
    
}
*/
/*
var json: Array!

func parsing(obj: NSData){
    do {
        json = try NSJSONSerialization.JSONObjectWithData(JSONData, options: NSJSONReadingOptions()) as? Array
    } catch {
        print(error)
    }

    if let item = json[0] as? [String: AnyObject] {
        if let person = item["person"] as? [String: AnyObject] {
            if let age = person["age"] as? Int {
                print("Dani's age is \(age)")
            }
        }
    }
*/
/*
enum jsonCourseData{
    case arrayOfUsers([Int])
    case courseName(Swift.String)
    case courseID(Int)
    case coursePrice(Double)
    case vimeoID(Int)
    case nilVal
    
    static func bundle(obj: AnyObject) -> jsonCourseData {
        if let arr = obj as? [AnyObject] {
            return arrayOfUsers(arr as! [Int])
        }
        if let name = obj as? [Swift.String: AnyObject] {
            return courseName(Swift.String(name))
        }
        if let id = obj as? Int {
            return courseID(id)
        }
        if let price = obj as? Double {
            return coursePrice(price)
        }
        if let vimId = obj as? Int {
            return vimeoID(vimId)
        }
        //if let num = obj as? NSData {
        //    return jsonCourseData
        //}
        assert(obj is NSNull, "Unsupported Type")
        return jsonCourseData(nilVal)
    }
    
    static func parseJSON(json: NSData) -> jsonCourseData? {
        var error: NSError?
        if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData as NSData, options: NSJSONReadingOptions.AllowFragments, error: let error) {
            return bundle(jsonCourseData)
        }
        return nil
    }
    
    internal var stringVal: Swift.String? {
        switch self {
        case .courseName(let str):
            return str
        default:
            return nil
        }
    }

    func get_json_coursedata(data: NSData) -> jsonCourseData{
        let json = data as jsonCourseData
        // to be finished
    }

    func parse_json_data()
    {
        let url_to_request:NSURL = NSURL(string: jsonPath)!
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url_to_request)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        request.timeoutInterval = 10
        let task = session.dataTaskWithRequest(request)
            {
                (let data, let response, let error) in
                guard let _:NSData = data, let _:NSURLResponse = response where error == nil else {
                    print("error")
                    return
                }
            self.get_json_coursedata(data!)
        }
        task.resume()
    }
}


//
let requestURL: NSURL = NSURL(string: "http://www.learnswiftonline.com/Samples/subway.json")!
let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
let session = NSURLSession.sharedSession()
let task = session.dataTaskWithRequest(urlRequest) {
(data, response, error) -> Void in

let httpResponse = response as! NSHTTPURLResponse
let statusCode = httpResponse.statusCode

if (statusCode == 200) {
print("Everyone is fine, file downloaded successfully.")
}
}

}

// json to NSData
func jsonToNSData(json: AnyObject) -> NSData?{
do {
return try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
} catch let myJSONError {
print(myJSONError)
}
return nil;
}
task.resume()
*/
