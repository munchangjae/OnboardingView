//
//  OnBoardingPageViewController.swift
//  practiceProject
//
//  Created by 문창재 on 2022/06/02.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var Pages = [UIViewController]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeData()
        makebutton()
        self.dataSource = self
        
    }
    
    func makeData() {
        let OnVC1 = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
        OnVC1.topImage = "onboard1"
        OnVC1.topTitle = "Welcome To Apple Education"
        OnVC1.bottomTitle = "무언가를 학습하고 창의성을 발휘하는 데는 각자 저마다의 방식이 있기 마련이죠. Apple의 기술과 리소스는 모든 유형의 교육자와 학생이 자신이 원하는 대로 학습하고, 창조하고, 자신만의 방식으로 성공을 일굴 수 있는 힘을 선사합니다. 더 나은 세상을 만드는 일, 함께 시작해볼까요?"
        
        let OnVC2 = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
        OnVC2.topImage = "onboard2"
        OnVC2.topTitle = "창의적으로 배우기"
        OnVC2.bottomTitle = "창의성 기반 학습이 학생들의 학업 성취도에 끼치는 긍정적인 영향에 대해 알아보세요."
        
        
        let OnVC3 = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
        OnVC3.topImage = "onboard3"
        OnVC3.topTitle = "새로운 Mac과 iPad를 Apple 교육 할인가로 만나보세요"
        OnVC3.bottomTitle = "대학 재학생과 신입생, 그리고 직급과 관계없이 모든 교직원이 혜택을 이용할 수 있습니다.각주* 먼저 자격 여부부터 확인하세요."
    
        
        Pages.append(OnVC1)
        Pages.append(OnVC2)
        Pages.append(OnVC3)
        
        setViewControllers([OnVC1], direction: .forward, animated: true)
    }

    func makebutton() {
        
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(dismissbutton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        self.view.addSubview(button)
    }

    @objc func dismissbutton() {
        self.dismiss(animated: true)
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = Pages.firstIndex(of: viewController) else { return nil
        }
        if currentIndex == 0 {
            return Pages.last
        }else {
            return Pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = Pages.firstIndex(of: viewController) else {
            return nil
        }
        
        if currentIndex == 2 /* Pages.count - 1 : 마지막 페이지 */ {
            return Pages.first
        }else {
            return Pages[currentIndex + 1]
        }
    }
    
    
}
