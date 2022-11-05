//
//  ViewModel.swift
//  RxTimer
//
//  Created by 강민규 on 2022/11/06.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

struct ViewModel {

    func rxswiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
        let url = URL(string: imageUrl)!
        return Observable.create { seal in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in

                        guard let data = data else {
                            seal.onNext(nil)
                            seal.onCompleted()
                            return
                        }

                        let image = UIImage(data: data)
                            seal.onNext(image)
                            seal.onCompleted()
                    }
                    task.resume()

            return Disposables.create()
        }
    }
}
