//
//  Repo.swift
//  RxTimer
//
//  Created by 강민규 on 2022/12/12.
//

import Foundation

import RxSwift

let LARGER_IMAGE_URL = "https://picsum.photos/1280/720/?random"

class APIService {
    static func fetchData() -> Observable<Data> {
        return Observable.create { ob in
            URLSession.shared.dataTask(with: URL(string: LARGER_IMAGE_URL)!) { data, result, err in
                if let err = err {
                    ob.onError(err)
                    return
                }
                guard let data = data else {
                    return
                }
                
                ob.onNext(data)
            }.resume()
            
            ob.onCompleted()
            return Disposables.create()
        }
    }
}
