import RxSwift
import Moya
import ObjectMapper

struct ApiService {
    let disposeBag: DisposeBag = DisposeBag()
    
    func login(params: ApiRequestLoginModel) -> Observable<ApiResponseLoginModel>? {
        guard let params = params.convertToDict() else { return nil }
        let target = MultiTarget(ApiBaseDefine.login(params: params))
        return DefaultProvider.request(target: target)
    }
}
