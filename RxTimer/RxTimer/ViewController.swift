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
    
    lazy var timeLable: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize:24)
        label.textAlignment = .center
        return label
    }()
    
    lazy var picture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:
                                "questionmark")
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    lazy var changeButton: UIButton = {
       let button = UIButton()
        button.setTitle("사진 변경", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    var containerView: UIView = {
       let view = UIView()
        view.layer.borderWidth = 1.0
        return view
    }()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.layer.borderWidth = 1.0
        return tableView
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
            .bind {
                self.loadImage()
            }
            .disposed(by: disposeBag)
        
        viewModel.timerOn()
            .observe(on: MainScheduler.instance)
            .bind { str in
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
        view.addSubview(containerView)
        containerView.addSubview(picture)
        containerView.addSubview(changeButton)
        view.addSubview(tableView)
    }
    
    func setConstraint() {
        timeLable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(10)
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(timeLable.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(containerView.snp.top).offset(-20)
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(250)
        }
        
        picture.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        changeButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).offset(-100)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.trailing.equalTo(containerView.snp.trailing).offset(-50)
        }
    }
}


