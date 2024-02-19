
import Foundation

enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum RequestType {
    case urlEncoded
    case raw
}

enum AuthType {
    /// default means no authenticatio is available
    case `default`
    case  basic
}

enum NetworkRequestError: LocalizedError {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case noNetwork
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
    case somethingWentWrong(_ error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest: return "Invalid Request"
        case .badRequest: return "Bad Request"
        case .unauthorized: return "Unauthorized"
        case .forbidden: return "Unauthorized"
        case .notFound: return "Not Found"
        case .error4xx(let code), .error5xx(let code): return "Error: \(code)"
        case .serverError: return "Unauthorized"
        case .decodingError: return "Decoding error"
        case .urlSessionFailed(_): return "URL Session Failed"
        case .unknownError: return "Unknown Error"
        case .noNetwork: return "Please check network connection"
        case .somethingWentWrong(let e): return "Error: \(e.localizedDescription)"
        }
    }
}

protocol Request {
    var path: String { get }
    var method: RequestMethod { get }
    var requestType: RequestType { get }
    var body: [String: Any] { get }
    var headers: [String: String]? { get }

    associatedtype ResponseType: Codable
}

extension Request {

    // Defaults
    var method: RequestMethod { return .GET }
    var requestType: RequestType { return .raw }
    var contentType: String { return "application/json" }
    var headers: [String: String]? { return nil }

}

protocol DSNetworkingDelegate: AnyObject {
    /**
     following delegates having default implementation
     */
    func checkReachability() -> ReachabilityStatus
    func errorNetworkNotReachable()
}


class DSNetworking {
    
    var authType: AuthType = .default //No Auth
    var authID = ""
    var authPassword = ""
    var BASIC_AUTH_64_STRING = ""
    
    //can update timeout after initializing the object also
    var timeOut = 15.0
    
    var tag: Int = 0
    
    weak var delegate: DSNetworkingDelegate?

    typealias callBack = (_ response: Any?, _ error: Error?, _ responseHeader: URLResponse?)->Void

    private var session: URLSession!
    
    init(timeOut: TimeInterval = 15.0, waitForConnectivity: Bool = false) {
        self.timeOut = timeOut
        let defaultConfig = URLSessionConfiguration.default
        self.session = URLSession(configuration: defaultConfig, delegate: nil, delegateQueue: OperationQueue.main)
        if #available(iOS 11, *) {
            defaultConfig.waitsForConnectivity = waitForConnectivity
        }
    }
    
    func callAPI(url: String, params: [String: Any], method: RequestMethod, requestType: RequestType = .raw, header: [String: String] = [:], handler:@escaping callBack) {
        
        guard self.delegate?.checkReachability() != .notReachable else {
            handler(nil,NSError(localizedDescription: ErrorText.networkNotReachable.rawValue), nil)
            self.delegate?.errorNetworkNotReachable()
            return
        }
       
        guard let request = self.requestUsing(url: url, params: params, method: method, requestType: requestType, header: header) else { return }
        
        self.dataTask(with: request) { response, error, responseHeader in
            DSNW_Print("response for \(method.rawValue) \(request.url?.absoluteString ?? "")  \n \(JSON(params))\nResponse ==> \n\(JSON(response ?? "unable to parse json"))" )
            handler(response, error, responseHeader)
        }
    }
    
    func callAPI<ReturnType: Decodable>(request: any Request) async -> Result<ReturnType, NetworkRequestError>  {
        
        guard self.delegate?.checkReachability() != .notReachable else {
            self.delegate?.errorNetworkNotReachable()
            return .failure(.noNetwork)
        }
       
        guard let urlRequest = self.requestUsing(url: request.path, params: request.body , method: request.method, requestType: request.requestType, header: request.headers ?? [:]) else {
            return  .failure(.badRequest) }
        
        do {
            // Hit Network call
            let result: (data: Data, response: URLResponse) =  try await session.data(for: urlRequest)
            if let response = result.response as? HTTPURLResponse,
               !(200...299).contains(response.statusCode) {
               
                DSNW_Print("response for \(request.method.rawValue) \(request.path)  \n \(JSON(request.body ))\nResponse ==> \n\(JSON(result.response))" )
                return .failure(httpError(response.statusCode))
            }
            
            let responseString = String(decoding: result.data, as: UTF8.self)
            DSNW_Print("response for \(request.method.rawValue) \(request.path)  \n \(JSON(request.body ))\nResponse ==> \n\(JSON(responseString))" )
            do {
                let finalResult = try JSONDecoder().decode(ReturnType.self, from: result.data)
                return .success(finalResult)
            } catch(let e) {
                print("Decoding error: \(e)")
                return .failure(.decodingError)
            }
        } catch(let e) { // handling any error
            return .failure(.somethingWentWrong(e))
        }
    }
    
    private func requestUsing(url: String,
                              params: [String: Any],
                              method: RequestMethod,
                              requestType: RequestType = .raw,
                              header: [String: String] = [:]) -> URLRequest? {
        
        guard let mURL = URL(string: url) else {
            DSNW_Print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: mURL)
        
        request.timeoutInterval = self.timeOut
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        if let authString = self.getAuthenticationString() {
            request.setValue(authString, forHTTPHeaderField: "Authorization")
        }

        if method == .POST || method == .PUT || method ==  .DELETE {
            switch requestType {
                
            case .raw:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = self.dataWRawRequest(params: params)
                
            case .urlEncoded:
                
                let dataToSend = self.dataWithUrlEncodedRequest(params: params)
                
                request.setValue("\(dataToSend?.count ?? 0)", forHTTPHeaderField: "Content-Length")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                request.httpBody = dataToSend
            }
        } else if method == .GET {
            guard let dataToSend = self.dataWithUrlEncodedRequest(params: params) else {
                DSNW_Print("Invalid params")
                return nil
            }
            guard let strData = String(data: dataToSend, encoding: .utf8) else {
                DSNW_Print("Invalid encoding in GET")
                return nil
            }
            let finalUrlString = "\(mURL)?\(strData)"
            guard let finalURL = URL(string: finalUrlString) else {
                DSNW_Print("Invalid URL creation")
                return nil
            }
            request.url = finalURL
        }
        
        //setting header fields
        request.allHTTPHeaderFields = header
                
        return request
    }
    
    private func dataTask(with request: URLRequest, handler: @escaping callBack) {
        
        self.session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async(execute: {
                                
                if let error = error {
                    DSNW_Print(error)
                    handler(nil,error, response)
                }
                
                guard let unwrappedData = data else {
                    DSNW_Print(error)
                    handler(nil,error, response)
                    return
                }
                
                let jsonObj = try? JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments)
                handler(jsonObj,error, response)
            })
        }.resume()
    }
}


//MARK: - Private func -
extension DSNetworking {
    private func getAuthenticationString()-> String? {
        switch self.authType {
        case .default:
            return nil
        case .basic:
            if !self.BASIC_AUTH_64_STRING.isEmpty {
                return self.BASIC_AUTH_64_STRING
            } else {
                let authStr = "\(self.authID):\(self.authPassword)"
                if let authData = authStr.data(using: .utf8) {
                    let authValue = "Bearer \(authData.base64EncodedData(options: Data.Base64EncodingOptions(rawValue: 0)))"
                    return authValue
                } else {
                    return nil
                }
            }
        }
    }
    
    private func dataWithUrlEncodedRequest(params: [String : Any]?) -> Data? {
        guard let anEncoding = params?.urlEncoding().data(using: .utf8) else {
            return nil
        }
        return anEncoding
    }
    
    
    private func dataWRawRequest(params : [String : Any]?) -> Data? {
        var jsonData: Data? = nil
        if let aParams = params {
            jsonData = try? JSONSerialization.data(withJSONObject: aParams, options: .prettyPrinted)
        }
        if jsonData != nil {
            return jsonData
        } else {
            return nil
        }
    }
}


extension DSNetworkingDelegate {
    
    func checkReachability() -> ReachabilityStatus {
        guard let reach = Reachability.networkReachabilityForInternetConnection() else {
            return ReachabilityStatus.notReachable
        }
        return reach.currentReachabilityStatus
    }
    
    func errorNetworkNotReachable() {
        DSNW_Print(ErrorText.networkNotReachable.rawValue)
    }
}


//MARK: - Dictionary(URLEncoded)
fileprivate extension Dictionary {
    
    func urlEncode(obj: Any)-> String {
        return "\(obj)"
    }
    
    func urlEncoding()-> String {
        var a:[String] = []
        for (key,value) in self {
            let part = "\(self.urlEncode(obj: key))=\(self.urlEncode(obj: value))"
            a.append(part)
        }
        let final = a.joined(separator: "&")
        return final
    }
}

fileprivate enum ErrorText: String {
    case networkNotReachable = "Network is not reachable"

}

fileprivate extension NSError {
    
    convenience init(localizedDescription : String) {
        
        self.init(domain: "DSNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        
        self.init(domain: "DSNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}

extension DSNetworking {
    
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    fileprivate func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
}


extension DSNetworking {
    
    /**
     *
     taken from: https://fluffy.es/download-files-sequentially/
     Code to use above
     
     // remember to set maxConcurrent OperationCount to 1
     let queue = OperationQueue()
     queue.maxConcurrentOperationCount = 1
     
     let urls = [
     URL(string: "https://github.com/fluffyes/AppStoreCard/archive/master.zip")!,
     URL(string: "https://github.com/fluffyes/currentLocation/archive/master.zip")!,
     URL(string: "https://github.com/fluffyes/DispatchQueue/archive/master.zip")!,
     URL(string: "https://github.com/fluffyes/dynamicFont/archive/master.zip")!,
     URL(string: "https://github.com/fluffyes/telegrammy/archive/master.zip")!
     ]
     
     for url in urls {
     let operation = DownloadOperation(session: URLSession.shared, downloadTaskURL: url, completionHandler: { (localURL, response, error) in
     print("finished downloading \(url.absoluteString)")
     })
     
     queue.addOperation(operation)
     }
    */

    class DownloadOperation : Operation {
        
        private var task : URLSessionDownloadTask!
        
        private enum OperationState : Int {
            case ready
            case executing
            case finished
        }
        
        // default state is ready (when the operation is created)
        private var state : OperationState = .ready {
            willSet {
                self.willChangeValue(forKey: "isExecuting")
                self.willChangeValue(forKey: "isFinished")
            }
            
            didSet {
                self.didChangeValue(forKey: "isExecuting")
                self.didChangeValue(forKey: "isFinished")
            }
        }
        
        override var isReady: Bool { return state == .ready }
        override var isExecuting: Bool { return state == .executing }
        override var isFinished: Bool { return state == .finished }
        
        init(session: URLSession, downloadTaskURL: URL, completionHandler: ((URL?, URLResponse?, Error?) -> Void)?) {
            super.init()
            
            // use weak self to prevent retain cycle
            task = session.downloadTask(with: downloadTaskURL, completionHandler: { [weak self] (localURL, response, error) in
                
                /*
                 if there is a custom completionHandler defined,
                 pass the result gotten in downloadTask's completionHandler to the
                 custom completionHandler
                 */
                if let completionHandler = completionHandler {
                    // localURL is the temporary URL the downloaded file is located
                    completionHandler(localURL, response, error)
                }
                
                /*
                 set the operation state to finished once
                 the download task is completed or have error
                 */
                self?.state = .finished
            })
        }
        
        override func start() {
            /*
             if the operation or queue got cancelled even
             before the operation has started, set the
             operation state to finished and return
             */
            if(self.isCancelled) {
                state = .finished
                return
            }
            
            // set the state to executing
            state = .executing
            
            print("downloading \(self.task.originalRequest?.url?.absoluteString ?? "")")
            
            // start the downloading
            self.task.resume()
        }
        
        override func cancel() {
            super.cancel()
            
            // cancel the downloading
            self.task.cancel()
        }
    }
}

func DSNW_Print<T>(_ obj : T) {
    #if DEBUG
    print(obj)
    #endif
}
