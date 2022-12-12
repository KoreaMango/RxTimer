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

protocol ViewModelType {
    var fetchImage: AnyObserver<Void> { get }
    var recode: AnyObserver<Void> { get }
       
    var image: Observable<UIImage> { get }
    var recodedTimes: Observable<[String]> { get }
    var timerStart: Observable<String> { get }
}

class ViewModel: ViewModelType {
    let disposeBag = DisposeBag()
    
    // MARK: - 실제 사용될 Input
    let fetchImage: AnyObserver<Void>
    let recode: AnyObserver<Void>
    
    // MARK: - 실제 사용될 Output
    var image: Observable<UIImage>
    var recodedTimes: Observable<[String]>
    var timerStart: Observable<String>
    
    // MARK: - Init
    init(domain: Fetchable = Store()) {
        // 스트림
        let fetching = PublishSubject<Void>()
        let recoding = PublishSubject<Void>()
   
        let uiImage = BehaviorSubject<UIImage>(value: Mock.image )
        let times = BehaviorSubject<[String]>(value: [])
        let timer = BehaviorSubject<String>(value: "00:00:00")
        
        // INPUT
        fetchImage = fetching.asObserver()
        
        fetching
            .debug()
            .flatMap(domain.fetchImage)
            .subscribe(onNext: uiImage.onNext)
            .disposed(by: disposeBag)
        
        recode = recoding.asObserver()
    
    
        // OUTPUT
        image = uiImage.asObserver()
        
        recodedTimes = times
        
        timerStart = timer.asObserver()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timer
               .onNext(self.currentTime())
        }
       
           
    }

    // MARK: - Private
    private func currentTime() -> String {
        let fommater = DateFormatter()
        fommater.dateFormat = "HH:mm:ss"
        let currentTime = fommater.string(from: Date())
        
        return currentTime
    }
}

