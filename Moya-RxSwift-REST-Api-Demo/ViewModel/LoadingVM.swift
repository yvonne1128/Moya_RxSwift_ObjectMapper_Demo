//
//  LoadingService.swift
//  Moya-RxSwift-REST-Api-Demo
//
//  Created by E7 on 2022/12/21.
//

import Foundation

class LoadingVM: ObservableObject {
    static let instance = LoadingVM()
    
    @Published var isLoading = false
}
