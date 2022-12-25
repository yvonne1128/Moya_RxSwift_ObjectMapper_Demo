import Moya
import ObjectMapper
import RxSwift

// MARK: 設定是否顯示 Debug Log
let shouldShowLog = true

let DefaultProvider = ApiProvider(
    endpointClosure: endpointClosure,
    requestClosure: requestClosure,
    stubClosure: MoyaProvider.neverStub,
    callbackQueue: DispatchQueue.main,
    plugins: [networkLoggerPlugin, apiPlugin],
    trackInflights: false
)

// MARK: 設定 Request Header
private let endpointClosure = { (target: MultiTarget) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    
    let endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    
    do {
        var urlRequest = try endpoint.urlRequest()
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: .prettyPrinted)
    } catch let error {
        print(error)
    }
    return endpoint.adding(newHTTPHeaderFields: ["Content-Type": "application/json"])
}

// MARK: 設定 Request Timeout 時間
private let requestClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider<MultiTarget>.RequestResultClosure) in
    do {
        var urlRequest = try endpoint.urlRequest()
        urlRequest.timeoutInterval = 12
        closure(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

// MARK: 實例化 Plugin
private let apiPlugin = ApiPlugin()

// MARK: Debug Plugin
private let networkLoggerPlugin = NetworkLoggerPlugin(
    configuration: NetworkLoggerPlugin.Configuration(
        output: reversedPrint,
        logOptions: .verbose
    )
)

func reversedPrint(target: TargetType, items: [String]) {
    #if DEBUG
    guard shouldShowLog else { return }
    for item in items {
        print(item, separator: ",", terminator: "\n")
    }
    #endif
}

class ApiProvider: MoyaProvider<MultiTarget> {

    override init(
        endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider.neverStub,
        callbackQueue: DispatchQueue? = nil,
        session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        super.init(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            callbackQueue: callbackQueue,
            session: session,
            plugins: plugins,
            trackInflights: trackInflights
        )
    }
}

extension ApiProvider {
    func request<T: Mappable, U: TargetType>(target: U) -> Observable<T> {
        return self.rx.request(target as! MultiTarget)
            .retry(3)
            .asObservable()
            .mapObject(T.self)
    }
}
