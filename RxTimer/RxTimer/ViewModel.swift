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

class ViewModel {
    let LARGER_IMAGE_URL = "https://picsum.photos/1280/720/?random"
    var counter: Int = 0
    
    func rxswiftLoadImage() -> Observable<UIImage?> {
        let imageUrl : String = LARGER_IMAGE_URL
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
    
    func timerOn() -> Observable<String> {
        return Observable.create { observe in
            observe.onNext(self.time())
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                observe.onNext(self.time())
            }
            
            return Disposables.create()
        }
       
    }
    
    func time() -> String {
        var fommater = DateFormatter()
        fommater.dateFormat = "HH:mm:ss"
        var currentTime = fommater.string(from: Date())
        
        return currentTime
    }
}
