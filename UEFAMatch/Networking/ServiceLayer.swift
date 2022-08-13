//
//  ServiceLayer.swift
//  RBT
//
//  Created by Ali Merhie on 22/07/2021.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import MobileCoreServices

class ServiceLayer {
    
    class func request<T: Mappable>(router: URLRequestBuilder, model: T.Type, completion: @escaping (Result<BaseModel<T>, ErrorResponseModel>) -> ()) {
        
        do{
            APIManager.shared.sessionManager.request(
                try router.asURLRequest()
            ).validate().response { (data) in
                ServiceLayer.handleResponseData(data: data, completion: completion)
                
            }
        }catch{
            print(error.localizedDescription)
            completion(.failure(ErrorResponseModel()))
        }
    }
    class func uploadData<T: Mappable>(router: URLRequestBuilder,model:T.Type,data:NSData?,fileType:SendFileEnum?,completion: @escaping (Result<BaseModel<T>, ErrorResponseModel>) -> (), progress: @escaping (Float) -> ()){
        do{
            APIManager.shared.sessionManager.upload(multipartFormData: { multipartFormData in
                
                if let data = data {
                    let documentDirectory = NSTemporaryDirectory()
                    let localPath = documentDirectory.appending("\(UUID().uuidString).jpeg")
                    data.write(toFile: localPath, atomically: true)
                    let fileUrl = URL.init(fileURLWithPath: localPath)
                    let fileMimeType = mimeTypeForPath(path: fileUrl.absoluteString)
                    let fileName = fileUrl.lastPathComponent
                    multipartFormData.append(fileUrl, withName: fileType?.rawValue ?? "profilePicture",fileName: fileName , mimeType: fileMimeType)
                    
                }
                
                for (key, value) in router.parameters! {
                    if value is String || value is Int {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
            } ,to: URL(string: "\(router.baseURL)\(router.path)")!).validate().response(completionHandler: { (data) in
                
                ServiceLayer.handleResponseData(data: data, completion: completion)

            }).uploadProgress { value in
                print("Upload Progress: \(value.fractionCompleted)")
                let progressValue = Float(value.fractionCompleted)
                progress(progressValue)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    class func mimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    class func downloadMediaFile(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        AF.download(url).responseData { (data) in
            switch data.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    class func handleResponseData<T: Mappable>(data: AFDataResponse<Data?>, completion: @escaping (Result<BaseModel<T>, ErrorResponseModel>) -> ()){
        let result = data.result
        var responseBody = BaseModel<T>()
        var responseErrorBody = ErrorResponseModel()
        let statusCode = data.response?.statusCode ?? 1
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data.data ?? Data(), options: []) as? [String: Any] {
                responseBody = Mapper<BaseModel<T>>().map(JSON: json) ?? BaseModel<T>()
                responseErrorBody = Mapper<ErrorResponseModel>().map(JSON: json) ?? ErrorResponseModel()
                
            }
        } catch {
            completion(.failure(ErrorResponseModel()))
        }
        
        switch result{
        case .success(_):
            completion(.success(responseBody))
            break
        case .failure(let error):
            print(error)
            completion(.failure(responseErrorBody))
            break
        }
    }
}

enum CustomError:String,Error {
    case DownloadFaile = "Download Failed"
}

enum SendFileEnum:String {
    case profilePicture = "profilePicture"
    case eventBackground = "eventBackground"
}

