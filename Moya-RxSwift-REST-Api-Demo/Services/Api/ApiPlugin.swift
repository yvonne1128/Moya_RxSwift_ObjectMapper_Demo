import Foundation
import Moya
import KeychainSwift

public protocol Authorizable {
    var existToken: Bool {
        get
    }
}

final class ApiPlugin: PluginType {
    let loadingVM = LoadingVM.instance
    
    var token: String {
        get {
            let keychainSwift = KeychainSwift()
            guard let token = keychainSwift.get("token") else {
                return ""
            }
            
            return token
        }
    }
    
    // MARK: Before Api Request
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        if let authorizable = target as? Authorizable, authorizable.existToken == false {
            return request
        }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    // MARK: Will Api Request
    func willSend(_ request: RequestType, target: TargetType) {
        DispatchQueue.main.async {
            self.loadingVM.isLoading = true
        }
    }
    
    // MARK: After Api Request
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        DispatchQueue.main.async {
            self.loadingVM.isLoading = false
        }
    }
}
