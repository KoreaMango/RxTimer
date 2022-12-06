//
//  ViewController.swift
//  RxTimer
//
//  Created by 강민규 on 2022/11/05.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    lazy var timeLable : UILabel = {
        let label = UILabel()
        label.text = "Nil"
        label.font = UIFont.systemFont(ofSize:24)
        label.textAlignment = .center
        return label
    }()
    
    lazy var picture : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:
                                "questionmark")
        return imageView
    }()
    
    lazy var changeButton : UIButton = {
       let button = UIButton()
        button.setTitle("사진 변경", for: .normal)
        button.backgroundColor = .red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setView()
        setConstraint()
        bind()
    }

    func bind() {
        changeButton.rx.tap
            .bind{
                self.loadImage()
                print("Tap")
            }
            .disposed(by: disposeBag)
        
        viewModel.timerOn()
            .observe(on: MainScheduler.instance)
            .subscribe { str in
                self.timeLable.text = str
            }
        
    }
    
    func loadImage() {
        _ = viewModel.rxswiftLoadImage()
            .observe(on: MainScheduler.instance)
            .subscribe({ result in
                switch result {
                case let .next(image):
                    self.picture.image = image

                case let .error(err):
                    print(err.localizedDescription)

                case .completed:
                    break
                }
            })
    }
    
    func setView() {
        view.addSubview(timeLable)
        view.addSubview(picture)
        view.addSubview(changeButton)
    }
    
    func setConstraint() {
        timeLable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            make.height.equalTo(100)
        }
        
        picture.snp.makeConstraints { make in
            make.top.equalTo(timeLable.snp.bottom).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(picture.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
    }

}


