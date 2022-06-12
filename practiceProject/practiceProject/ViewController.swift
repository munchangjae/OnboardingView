//
//  ViewController.swift
//  practiceProject
//
//  Created by 문창재 on 2022/05/21.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
    }


    override func viewDidAppear(_ animated: Bool) {
        
        let OnboardVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        // 트랜지션 스타일은 페이지 뷰 컨트롤러를 인스턴스화 해줄 때 선언해야한다.
        
        OnboardVC.modalPresentationStyle = .fullScreen
        
        self.present(OnboardVC, animated: true)
        
        
    }
    
     
}


