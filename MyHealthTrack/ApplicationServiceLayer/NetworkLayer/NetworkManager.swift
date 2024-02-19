
import Foundation
import Combine

typealias NetworkCallBack = (_ response: Any?, _ error: Error?)->Void

class NetworkManager {

    static let shared = NetworkManager()
    
    private init() { }
    
    private let netwroking: DSNetworking = DSNetworking()

    private var subscribers: Set<AnyCancellable> = []

    func callAPI(url: String, params: JSONDictionary = [:], method: RequestMethod, requestType: RequestType, header: RequestHeader = [:], callBack: @escaping NetworkCallBack) {
        
        netwroking.callAPI(url: url, params: params, method: method, requestType: requestType, header: header) { response, error, responseHeader in
            
            callBack(response, error)
            
        }
    }
        
    func dispatch<R: Request>(_ request: R) async -> Result<R.ResponseType, NetworkRequestError> {
                
        let response:Result<R.ResponseType, NetworkRequestError> = await netwroking.callAPI(request: request)
        
        switch response {
        case .success( _): break
        case .failure(let failure): handleUnauthorizedAccess(failure)
        }
        
        return response
    }
    
    private func handleUnauthorizedAccess(_ error: NetworkRequestError) {
        switch error {
        case .unauthorized: NotificationManager.shared.sendLogoutNotification()
        default: print(error.errorDescription ?? "Something went wrong...!!!")
        }
    }
}
