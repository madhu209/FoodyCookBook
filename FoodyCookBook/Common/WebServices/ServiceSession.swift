//
//  ServiceSession.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//


import UIKit
var homeCatche = NSCache<NSString, NSArray>()

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class ServiceSession: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let session = URLSession.shared
    var urlRequest : URLRequest! = nil
    var isJSONArray : Bool = false
    var cactheKey : String!
    
    @objc class var shared : ServiceSession{
        
        struct singleton{
            static let instance = ServiceSession()
        }
        return singleton.instance
    }
    
    @objc func callToGetDataFromServer(appendUrlString: String, withIndicator: Bool = true, completionHandler: @escaping (_ data: Any) -> Void) {
        
        if !checkNetAvailability() {
            return
        }
        
        var urlString = Endpoint.staticEndpoint + appendUrlString
        
        if urlString.contains("maps.googleapis.com") {
            urlString = urlString.replacingOccurrences(of: Endpoint.staticEndpoint, with: "")
        }
        
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        
        #if DEBUG
        print(urlString)
        #endif
        
        if let url = URL(string: urlString) {
            
            if withIndicator == true {
                ActivityIndicator.shared.showActivity()
            }

            headerSetUP(url: url, httpMethod: HTTPMethod.get.rawValue)
            
            session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
                
                ActivityIndicator.shared.hideActivity()
                
                if error != nil {
                    debugPrint("fail to connect with error:\(String(describing: error?.localizedDescription))")
                    return
                }
                do {
                    
                    #if DEBUG
                    if let returnData = String(data: data ?? Data(), encoding: .utf8) {
                        debugPrint(returnData)
                        
                        if returnData == "" {
//                            AlertManager.shared.displayValidationAlert(message: "Empty response", controller: (self.appDelegate.window?.rootViewController)!)
                            return
                        }
                        
                    }
                    #endif
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:[]) //as? NSDictionary
                    
                    #if DEBUG
                    debugPrint(json)
                    #endif
                    
                    DispatchQueue.main.async {
                                 
                        DispatchQueue.main.async {
                            completionHandler(json)
                        }
                        
//                        let jsonDictionary = String.checkDictionary(json as Any)
//
//                        // if not success then show alert here only
//                        if (jsonDictionary["status"] as? Int ?? 0) != 200 {
//
//                            if jsonDictionary["status"] as? Int == 401 {
//
//                                DispatchQueue.main.async {
//
//                                    AlertManager.shared.displaySuccessAlert(message: "Your Session Timed out") { (_) in
//                                    }
//
//                                }
//                                return
//                            }
//
//                            if let errorMsg = jsonDictionary["errors"] as? String {
//
//                                if errorMsg != "" {
//                                    AlertManager.shared.displayErrorMessage(message: errorMsg)
//                                }
//                                else {
//                                    AlertManager.shared.displayErrorMessage(message: (jsonDictionary["message"] as? String ?? ""))
//                                }
//                            }
//                            else {
//                                DispatchQueue.main.async {
//                                    AlertManager.shared.displayErrorMessage(message: (jsonDictionary["message"] as? String ?? ""))
//
//                                }
//                            }
//                        }
//                        else {
//
//                        }
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        AlertManager.shared.displayErrorMessage(message: ConstantMessages.shared.apiErrorMessage)
                    }
                    
                    debugPrint("failed to Get Data from Server with error:%@",error)
                }
            }).resume()
            
        }
    }
    
    
    @objc func callToPostDataToServer(appendUrlString: String, isActivityShow : Bool = true, postBodyDictionary: Any, completionHandler: @escaping (_ data: Any) -> Void) {
        
        if !checkNetAvailability() {
            return
        }
        
        var urlString = Endpoint.staticEndpoint + appendUrlString
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
                
        if let url = URL(string: urlString) {
            
            headerSetUP(url: url, httpMethod: HTTPMethod.post.rawValue)

            if isActivityShow {
                ActivityIndicator.shared.showActivity()
            }
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: postBodyDictionary, options:[])
            }
            catch {
                debugPrint("JSON serialization failed:  \(error)")
            }
            
            session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
                
                DispatchQueue.main.async(execute: {
                    ActivityIndicator.shared.hideActivity()
                })
                
                debugPrint(data as Any)
                
                if data == nil {
                    DispatchQueue.main.async {
                        return
                    }
                }
                
                #if DEBUG
                if let returnData = String(data: data ?? Data(), encoding: .utf8) {
                    debugPrint(returnData)
                }
                #endif
                
                
                
                if error != nil {
                    debugPrint("fail to connect with error:\(String(describing: error?.localizedDescription))")
                    return
                }
                do {
                    
                    debugPrint("html")
                    debugPrint(String(decoding: data!, as: UTF8.self))
                    
                    if String(decoding: data!, as: UTF8.self) == "" {
                        return
                    }
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:[]) as Any
                    
                    #if DEBUG
                    debugPrint(json)
                    #endif
                                        
                    DispatchQueue.main.async {
                        
                        let jsonDictionary = json as? NSDictionary ?? NSDictionary()
                        
                        debugPrint(jsonDictionary)
                        
                        debugPrint(jsonDictionary["status"] as Any)
                        debugPrint(jsonDictionary["message"] as Any)

                        // if not success then show alert here only
                        if (jsonDictionary["status"] as? Int ?? 0) != 200 {
                            
                            if jsonDictionary["status"] as? Int == 401 {
                                
                                DispatchQueue.main.async {
                                    
                                    AlertManager.shared.displaySuccessAlert(message: "Your Session Timed out") { (_) in
                                    }
                                    
                                }
                                return
                            }
                            
                            if let errorMsg = jsonDictionary["errors"] as? String {
                                
                                // if error message not getting empty
                                if errorMsg != "" {
                                    
                                    if errorMsg == "Account is not verified\n Please verify your account through Login" {
                                        DispatchQueue.main.async {
                                            completionHandler(json)
                                        }
                                    }
                                    else {
                                        AlertManager.shared.displayErrorMessage(message: errorMsg)
                                    }
                                }
                                else {
                                    DispatchQueue.main.async {
                                        AlertManager.shared.displayErrorMessage(message: (jsonDictionary["message"] as? String ?? ""))
                                    }
                                }
                            }
                            else {
                                AlertManager.shared.displayErrorMessage(message: (jsonDictionary["message"] as? String ?? ""))
                            }

                        }
                        else {
                            DispatchQueue.main.async {
                                completionHandler(json)
                            }
                        }
                    }
                }catch {
                    DispatchQueue.main.async {
                        AlertManager.shared.displayErrorMessage(message: ConstantMessages.shared.apiErrorMessage)
                    }
                    
                    debugPrint("failed to Get Data from Server with error:%@",error)
                }
                
            }).resume()
        }
    }
    
    func callToDelete_Put_DataFromServer(appendUrlString: String, isActivityShow : Bool = true, serviceType: String, postBodyDictionary: Any = [], completionHandler: @escaping (_ data: Any) -> Void) {
        
        if !checkNetAvailability() {
            return
        }
        
        let urlString = Endpoint.staticEndpoint + appendUrlString
        
        #if DEBUG
        debugPrint(urlString)
        #endif
        
        if let url = URL(string: urlString) {
            
            headerSetUP(url: url, httpMethod: serviceType)
            
            if isActivityShow {
                ActivityIndicator.shared.showActivity()
            }
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: postBodyDictionary, options:[])
            }
            catch {
                debugPrint("JSON serialization failed:  \(error)")
            }
            
            session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
                
                DispatchQueue.main.async(execute: {
                    ActivityIndicator.shared.hideActivity()
                })
                if error != nil {
                    debugPrint("fail to connect with error:\(String(describing: error?.localizedDescription))")
                    return
                }
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:[]) //as? NSDictionary
                    
                    let jsonDictionary = json as? NSDictionary ?? NSDictionary()
                    
                    debugPrint(jsonDictionary)
                    
                    debugPrint(jsonDictionary["status"] as Any)
                    debugPrint(jsonDictionary["message"] as Any)
                    
                    // if not success then show alert here only
                    if (jsonDictionary["status"] as? Int ?? 0) != 200 {
                        
                        if jsonDictionary["status"] as? Int == 401 {
                            
                            DispatchQueue.main.async {
                                
                                AlertManager.shared.displaySuccessAlert(message: "Your Session Timed out") { (_) in
                                }
                                
                            }
                            return
                        }
                        
                        DispatchQueue.main.async {
                            AlertManager.shared.displayErrorMessage(message: (jsonDictionary["message"] as? String ?? ""))
                        }
                    }
                    else {
                        
                        #if DEBUG
                        debugPrint(json)
                        #endif
                        
                        DispatchQueue.main.async {
                            completionHandler(json)
                        }
                        
                    }
                    
                } catch {
                    
                    DispatchQueue.main.async {
                        AlertManager.shared.displayErrorMessage(message: ConstantMessages.shared.apiErrorMessage)
                    }
                    
                    debugPrint("failed to Get Data from Server with error:%@",error)
                }
            }).resume()
            
        }
    }
    
    func headerSetUP(url: URL, httpMethod: String) {
        
        if !checkNetAvailability() {
            return
        }
        
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let sessionToken = UserDefaults.standard.value(forKey: "SessionToken") as? String
        let companyID = UserDefaults.standard.value(forKey: "ClientID") as? String

        if sessionToken != nil {
            urlRequest.addValue(sessionToken!, forHTTPHeaderField: "Authorization")
            
            if companyID != nil {
                if companyID != "" {
                    urlRequest.addValue(companyID!, forHTTPHeaderField: "_cuid")
                }
            }
            
            if DeviceInfo.shared.deviceToken != "" {
                urlRequest.addValue(DeviceInfo.shared.deviceToken, forHTTPHeaderField: "device_token")
            }
            
        }
    }
    
    func checkNetAvailability() -> Bool {
        
        if NetworkManager.shared.netAvailability == false {
            NetworkManager.shared.internetConnectionNotAvailble()
            return false
        }
        
        return true
    }
    
    func convertJsonDictionaryToBinaryData(jsonDict: NSDictionary) -> Data {
        
        let payloadDictionary = jsonDict["meals"] as? NSArray ?? NSArray()
        
        debugPrint(payloadDictionary as Any)
        
        if let payloadJSONData = try? JSONSerialization.data(
            withJSONObject: payloadDictionary,
            options: []) {
            let payloadJSONText = String(data: payloadJSONData, encoding: .ascii)
            debugPrint("JSON string = \(payloadJSONText!)")
            
            let payloadjsonData = Data(payloadJSONText!.utf8)
            
            return payloadjsonData
            
        }
        
        #if DEBUG
        debugPrint("Error While converting Payload Dictionary to jsonString")
        #endif
        
        return Data()
    }
}

class DeviceInfo {

    static let shared = DeviceInfo()
    
    var deviceToken = ""
    var deviceName = UIDevice.current.systemName
    var isUserLogined = false
    var SCREEN_WIDTH = UIScreen.main.bounds.size.width
    var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    var deviceGuid = ""
    
}
