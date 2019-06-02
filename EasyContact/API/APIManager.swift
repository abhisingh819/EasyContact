//
//  APIManager.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/1/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import Foundation

class APIManager:NSObject{
    
    
    static let sharedInstance = APIManager()
    
    /**
     GET requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    let urlSession = URLSession.shared
    
    func doGet(urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,type:String,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        if let url = URL(string:urlString){
            
            let getRequest = URLRequest(url: url)
            let task = urlSession.dataTask(with: getRequest as URLRequest, completionHandler: { data, response, error in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    completionHandler(nil, nil)
                    return
                }
                print(response)
                
                guard error == nil else {
                    completionHandler(nil,nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil,nil)
                    return
                }
                
                do {
                    
                    // the data is returned in JSON format and needs to be converted into something that swift can work with
                    // we are converting it into a dictionary of type [String: Any]
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] {
                        print(json)
                        completionHandler(json as AnyObject,nil)
                    }else if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                        print(json)
                        completionHandler(json as AnyObject,nil)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil,error as NSError)
                }
            })
            
            task.resume()
        }
        
    }
    
    /**
     POST requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    
    
    func doPost(_ urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,type:String,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? [:], options: []) else { return }
        request.httpBody = httpBody
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil, nil)
                return
            }
            print(response)
            
            guard error == nil else {
                completionHandler(nil, nil)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            
            do {
                
                // the data is returned in JSON format and needs to be converted into something that swift can work with
                // we are converting it into a dictionary of type [String: Any]
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] {
                    print(json)
                    completionHandler(json as AnyObject,nil)
                }else if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    print(json)
                    completionHandler(json as AnyObject,nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completionHandler(nil,error as NSError)
            }
        })
        
        task.resume()
    }
    
    /**
     PUT requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    
    
    func doPut(_ urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? [:], options: []) else { return }
        request.httpBody = httpBody
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil, nil)
                return
            }
            print(response)
            
            guard error == nil else {
                completionHandler(nil, nil)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            
            do {
                
                // the data is returned in JSON format and needs to be converted into something that swift can work with
                // we are converting it into a dictionary of type [String: Any]
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] {
                    print(json)
                    completionHandler(json as AnyObject,nil)
                }else if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    print(json)
                    completionHandler(json as AnyObject,nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completionHandler(nil,error as NSError)
            }
        })
        
        task.resume()
        
    }
    
    /**
     DELETE requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    
    func doDelete(_ urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil, nil)
                return
            }
            print(response)
            guard error == nil else {
                completionHandler(nil, nil)
                return
            }
            let deleteString = "Success"
            completionHandler(deleteString as AnyObject,nil)
            
        })
        
        task.resume()
        
    }
}


