//
//  Store.swift
//  RxTimer
//
//  Created by 강민규 on 2022/12/12.
//

import Foundation
import UIKit

import RxSwift

protocol Fetchable {
    func fetchImage() -> Observable<UIImage>
}

class Store: Fetchable {
    func fetchImage() -> Observable<UIImage> {
        return APIService.fetchData()
            .map { data in
                if let image = UIImage(data: data){
                    return image
                }
                return Mock.failImage
            }
        
    }
}
