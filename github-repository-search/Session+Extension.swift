//
//  Session+Extension.swift
//  github-repository-search
//
//  Created by konojunya on 2017/07/03.
//  Copyright © 2017年 konojunya. All rights reserved.
//

import APIKit
import RxSwift

extension Session {
    
    public static func rx_response<T: Request>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = send(request) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
}
