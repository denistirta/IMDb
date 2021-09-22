//
//  Manager.swift
//  IMDb
//
//  Created by DenisTirta on 21/09/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

func AFReq(method: HTTPMethod = .get, url: String, param: [String:Any]? = nil, responValue: String = "JSON", view: UIView, position : ToastPosition = .bottom, showToas: Bool = true, completion: @escaping (_ success: Bool, _ json: JSON, _ statusCode: Int) -> Void) {
        
    AF.request(url, method: method, parameters: param, encoding: JSONEncoding.default, headers: HTTPHeaders())
        .validate(statusCode: 200..<300)
        .responseJSON { response in
        switch response.result{
        case .success(let json):
            
            let dict = JSON(json)
            
            completion(true, dict, response.response?.statusCode ?? 0)
        case .failure(let error):
            print("DebugDescription = \(response.debugDescription)")
            print("StatusCode = \(response.response?.statusCode ?? 0)")
            print("Error localizedDescription = \(error.localizedDescription)")
            
            let dictFailure = JSON(response.data ?? Data())
            print("error = \(dictFailure)")
            
            switch response.response?.statusCode {
            case 500:
                if showToas{
                    view.toasShow(msg: "error 500", position: position)
                }
                completion(false, JSON.null, response.response?.statusCode ?? 0)
            case 400:
                if showToas{
                    if !dictFailure["status_message"].stringValue.isEmpty{
                        view.toasShow(msg: dictFailure["status_message"].stringValue, position: position)
                    }else{
                        view.toasShow(msg: error.localizedDescription, position: position)
                    }
                }
                completion(false, dictFailure, response.response?.statusCode ?? 0)
            case 401:
                NotificationCenter.default.post(name: Notification.Name("logout"), object: nil, userInfo: nil)
                if showToas{
                    view.toasShow(msg: "error 401", position: position)
                }
                return
            case 404:
                if showToas{
                    if !dictFailure["status_message"].stringValue.isEmpty{
                        view.toasShow(msg: dictFailure["status_message"].stringValue, position: position)
                    }else{
                        view.toasShow(msg: error.localizedDescription, position: position)
                    }
                }
                completion(false, dictFailure, response.response?.statusCode ?? 0)
            case 422:
                if showToas{
                    if !dictFailure["status_message"].stringValue.isEmpty{
                        view.toasShow(msg: dictFailure["status_message"].stringValue, position: position)
                    }else{
                        view.toasShow(msg: error.localizedDescription, position: position)
                    }
                }
                completion(false, dictFailure, response.response?.statusCode ?? 0)
            case 504, 408:
                //MARK:- timeout
                if showToas{
                    if !dictFailure["status_message"].stringValue.isEmpty{
                        view.toasShow(msg: dictFailure["status_message"].stringValue, position: position)
                    }else{
                        view.toasShow(msg: error.localizedDescription, position: position)
                    }
                    completion(false, dictFailure, response.response?.statusCode ?? 0)
                }
            default:
                if showToas{
                    view.toasShow(msg: error.localizedDescription, position: position)
                }
                completion(false, JSON.null, response.response?.statusCode ?? 0)
            }
        }
    }

}

