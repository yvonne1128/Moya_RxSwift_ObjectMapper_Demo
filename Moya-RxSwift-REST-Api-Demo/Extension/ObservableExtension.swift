import Foundation
import Moya
import RxSwift
import ObjectMapper

extension ObservableType where Element == Response {
    func mapObject<T: Mappable>(_ : T.Type) -> Observable<T> {
        return self.map { response in
            let jsonString = String(bytes: response.data, encoding: .utf8)
            
            guard response.statusCode == 200 else {
                throw Mapper<ApiResponseErrorModel>().map(JSONString: jsonString!) ?? RxSwiftMoyaError.ParseJSONError
            }

            return Mapper<T>().map(JSONString: jsonString!)!
        }
    }
}

enum RxSwiftMoyaError: String, Error {
    case ParseJSONError
    case OtherError
}
