import Foundation
import RxSwift
import KeychainSwift

class Authenticator: ObservableObject {
    @Published var isLogin: Bool
    @Published var loginError: String
    
    init() {
        isLogin = false
        loginError = ""
    }
    
    let disposeBag = DisposeBag()
    
    func login(email: String, password: String) {
        let loginModel = ApiRequestLoginModel(email: email, password: password)
        ApiService().login(params: loginModel)?.subscribe(onNext: { result in
            self.isLogin = true
            let result = result as ApiResponseLoginModel
            let keychainSwift = KeychainSwift()
            keychainSwift.set(result.token, forKey: "token")
        }, onError: { error in
            let error = error as! ApiResponseErrorModel
            self.loginError = error.errorMessage
        }, onCompleted: {
            print("Login API 完成")
        }, onDisposed: {})
    }
    
    func logout() {
        isLogin = false
    }
}
