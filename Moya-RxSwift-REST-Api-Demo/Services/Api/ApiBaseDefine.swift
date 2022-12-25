import Foundation
import Moya

enum ApiBaseDefine {
    case login(params: [String: Any])
}

extension ApiBaseDefine: TargetType {
    var baseURL: URL {
        return URL(string: "https://reqres.in")!
    }
    
    var path: String {
        switch self {
        case .login(_):
            return "/api/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Moya.Task {        
        switch self {
        case .login(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
