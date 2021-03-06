//  Client.swift
//  OnTheMap
//
//  Created by Carlos Lozano on 9/10/17.
//  Copyright © 2017 Carlos Lozano. All rights reserved.
//

import Foundation


class Client {
    
    
    func sendError(_ error: String,completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?)->Void) {
        print(error)
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandler(nil, NSError(domain: "get method", code: 1, userInfo: userInfo))
    }
    
    
    func sendError(_ error: String,code:Int,completionHandler: @escaping (_ result: Data?, _ error: NSError?)->Void) {
        print(error)
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandler(nil, NSError(domain: "get method", code: code, userInfo: userInfo))
    }
    
    
    
    func get (getUrl:String, getPath: String ,parameters: [String: AnyObject], headers: [String: String] ,completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?)->Void) -> URLSessionDataTask{
    
        let url = prepareURL(host: getUrl, path: getPath, parameters: parameters)
        
        let request = prepareRequest(requestUrl: url, headers: headers, method: Client.requestConstants.verbs.get)
        
        let task = URLSession.shared.dataTask(with: request){
            (data,response,error) in
            if error != nil {
               self.sendError("the request has an error", completionHandler: completionHandler)
            }
            else{
                
                guard let responseStatus: Int = (response as! HTTPURLResponse).statusCode, responseStatus>199 && responseStatus<=299 else{
                    self.sendError("the resquest responde with a status greater than 299", completionHandler: completionHandler)
                    return
                }
                
                do {
                    guard let responseData: AnyObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as AnyObject  else{
                        self.sendError("unable to parse data", completionHandler: completionHandler)
                        return
                    }
                    completionHandler(responseData,nil)
                
                }catch {
                     self.sendError("unable to parse data", completionHandler: completionHandler)
                
                }
            }
        }
        task.resume()
        return task
    }
    
    
    
   
    
    func getData (getUrl:String, getPath: String ,parameters: [String: AnyObject], headers: [String: String],completionHandler: @escaping (_ resultWithData: Data?, _ error: NSError?)->Void) -> URLSessionDataTask{
        
        print(getUrl)
        print(getPath)
        
        let url = prepareURL(host: getUrl, path: getPath, parameters: parameters)
        
        let request = prepareRequest(requestUrl: url, headers: headers, method: Client.requestConstants.verbs.get)
        
        
        let task = URLSession.shared.dataTask(with: request){
            (data,response,error) in
            if error != nil {
                self.sendError("No connection with the server",code:0, completionHandler: completionHandler)
            }
            else{
                print(error)
                print((response as! HTTPURLResponse).statusCode)
                guard let responseStatus: Int = (response as! HTTPURLResponse).statusCode, responseStatus>199 && responseStatus<=299 else{
                    self.sendError("the resquest responde with a status greater than 299",code:1, completionHandler: completionHandler)
                    return
                }
                completionHandler(data,nil)
                
            }
        }
        task.resume()
        return task
    }
    
    
    

    
    
    func post (postUrl:String, postPath: String ,parameters: [String: AnyObject], headers: [String: String],body:String,completionHandler: @escaping (_ result: Data?, _ error: NSError?)->Void) -> URLSessionDataTask{
        
        
        print(body)
        print(postUrl)
        print(postPath)
        print(parameters)
        
        
        
        let url = prepareURL(host: postUrl, path: postPath, parameters: parameters)
        
        let request = prepareRequest(requestUrl: url, headers: headers, method: Client.requestConstants.verbs.post, body:body)
        
        
        let task = URLSession.shared.dataTask(with: request){
            (data,response,error) in
            if error != nil {
                self.sendError("No connection with the server",code:0, completionHandler: completionHandler)
            }
            else{
                
                print((response as! HTTPURLResponse).statusCode)
                guard let responseStatus: Int = (response as! HTTPURLResponse).statusCode, responseStatus>199 && responseStatus<=299 else{
                    self.sendError("the resquest responde with a status greater than 299",code:1, completionHandler: completionHandler)
                    return
                }
                completionHandler(data,nil)
                    
            }
        }
        task.resume()
        return task
    }
    
    
    
    func put (putUrl:String, putPath: String ,parameters: [String: AnyObject], headers: [String: String],body:String,completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?)->Void) -> URLSessionDataTask{
        
        let url = prepareURL(host: putUrl, path: putPath, parameters: parameters)
        
        let request = prepareRequest(requestUrl: url, headers: headers, method: Client.requestConstants.verbs.put, body:body)
        
        let task = URLSession.shared.dataTask(with: request){
            (data,response,error) in
            if error != nil {
                self.sendError("No connection with the server", completionHandler: completionHandler)
            }
            else{
                
                
                guard let responseStatus: Int = (response as! HTTPURLResponse).statusCode, responseStatus>199 && responseStatus<=299 else{
                    self.sendError("the resquest responde with a status greater than 299", completionHandler: completionHandler)
                    return
                }
                
                do {
                    guard let responseData: AnyObject = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as AnyObject  else{
                        self.sendError("unable to parse data", completionHandler: completionHandler)
                        return
                    }
                    completionHandler(responseData,nil)
                    
                }catch {
                    self.sendError("unable to parse data", completionHandler: completionHandler)
                    
                }
            }
        }
        task.resume()
        return task
    }
    
    func delete(deleteUrl:String, deletePath: String ,parameters: [String: AnyObject], headers: [String: String] ,completionHandler: @escaping (_ result: Data?, _ error: NSError?)->Void) -> URLSessionDataTask{
        
        let url = prepareURL(host: deleteUrl, path: deletePath, parameters: parameters)
        
        let request = prepareRequest(requestUrl: url, headers: headers, method: Client.requestConstants.verbs.delete)
        
        let task = URLSession.shared.dataTask(with: request){
             (data,response,error) in
                if error != nil {
                    self.sendError("No connection with the server",code:0, completionHandler: completionHandler)
                }
                else{
                    guard let responseStatus: Int = (response as! HTTPURLResponse).statusCode, responseStatus>199 && responseStatus<=299 else{
                        self.sendError("the resquest responde with a status greater than 299",code:1, completionHandler: completionHandler)
                        return
                    }
                    completionHandler(data,nil)
            }
        }
        task.resume()
        return task
    }
    
    func prepareURL(host: String, path: String, parameters: [String: AnyObject] )->URL{
        
        var urlComponents = URLComponents ()
    
        urlComponents.scheme = Client.requestConstants.scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [URLQueryItem]()
        
        for (key,value) in parameters{
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value as? String))
        }
        return urlComponents.url!
    }
    
    
    func prepareRequest(requestUrl:URL, headers: [String: String], method: String, body: String) -> URLRequest{
        let request = NSMutableURLRequest(url: requestUrl)
        request.httpMethod = method
        request.httpBody = body.data(using: .utf8)
        
        for (key,value) in headers{
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request as URLRequest
    }
    
    func prepareRequest(requestUrl:URL, headers: [String: String], method: String) -> URLRequest{
        let request = NSMutableURLRequest(url: requestUrl)
        request.httpMethod = method
        for (key,value) in headers{
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request as URLRequest
    }
}
